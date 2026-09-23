#!/usr/bin/env python3
"""
Build a SKOS thesaurus from a health DCAT vocabulary endpoint.

Usage:
  python3 build-health-thesaurus.py <input-url> <output-file>

Example:
  python3 build-health-thesaurus.py \
    https://hdeu-dcat.acceptance.data.health.europa.eu/resource/authority/coding-system/ \
    ../resources/thesauri/theme/health-coding-system.rdf
  python3 build-health-thesaurus.py \
    https://hdeu-dcat.acceptance.data.health.europa.eu/resource/authority/health-theme \
    ../resources/thesauri/theme/health-theme.rdf
"""

import sys
import urllib.request
import xml.etree.ElementTree as ET

RDF  = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
SKOS = "http://www.w3.org/2004/02/skos/core#"
OWL  = "http://www.w3.org/2002/07/owl#"

NS = {
    "rdf":  RDF,
    "skos": SKOS,
    "owl":  OWL,
}


def fetch_rdf(url: str) -> ET.Element:
    req = urllib.request.Request(url, headers={"Accept": "application/rdf+xml"})
    with urllib.request.urlopen(req, timeout=30) as resp:
        return ET.fromstring(resp.read())


def is_concept_scheme(desc: ET.Element) -> bool:
    """Return True if this rdf:Description is a skos:ConceptScheme."""
    cs_uri = f"{{{SKOS}}}ConceptScheme"
    owl_onto = f"{{{OWL}}}Ontology"
    type_tag = f"{{{RDF}}}type"
    return any(
        t.get(f"{{{RDF}}}resource") in (
            f"{SKOS}ConceptScheme",
            f"{OWL}Ontology",
        )
        for t in desc.findall(type_tag)
    ) or desc.find(f".//{{{SKOS}}}hasTopConcept") is not None


def description_to_concept_scheme(desc: ET.Element) -> ET.Element:
    """Convert a rdf:Description for a ConceptScheme to skos:ConceptScheme."""
    about = desc.get(f"{{{RDF}}}about")
    elem = ET.Element(f"{{{SKOS}}}ConceptScheme")
    elem.set(f"{{{RDF}}}about", about)
    # Copy all child elements, skipping rdf:type (already implied by tag)
    for child in desc:
        if child.tag != f"{{{RDF}}}type":
            elem.append(child)
    return elem


def description_to_concept(desc: ET.Element) -> ET.Element:
    """Convert a rdf:Description for a concept to skos:Concept."""
    about = desc.get(f"{{{RDF}}}about")
    elem = ET.Element(f"{{{SKOS}}}Concept")
    elem.set(f"{{{RDF}}}about", about)
    # Copy all child elements, skipping rdf:type (already implied by tag)
    for child in desc:
        if child.tag != f"{{{RDF}}}type":
            elem.append(child)
    return elem


def fetch_full_concept(url: str) -> ET.Element | None:
    """Fetch the full concept document and return the primary rdf:Description."""
    try:
        root = fetch_rdf(url)
    except Exception as e:
        print(f"  WARNING: could not fetch {url}: {e}", file=sys.stderr)
        return None

    desc_tag = f"{{{RDF}}}Description"
    for desc in root.findall(desc_tag):
        about = desc.get(f"{{{RDF}}}about", "")
        # The primary description matches the requested URL exactly
        if about == url or about == url.rstrip("/"):
            return desc
    return None


def build_rdf_namespaces() -> dict:
    return {
        "rdf":    "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "skos":   "http://www.w3.org/2004/02/skos/core#",
        "owl":    "http://www.w3.org/2002/07/owl#",
        "dc":     "http://purl.org/dc/elements/1.1/",
        "dct":    "http://purl.org/dc/terms/",
        "rdfs":   "http://www.w3.org/2000/01/rdf-schema#",
        "xsd":    "http://www.w3.org/2001/XMLSchema#",
    }


def serialize(root: ET.Element, namespaces: dict) -> str:
    """Serialize an ElementTree to a pretty-printed RDF/XML string."""
    # Register namespaces so prefixes are used in output
    for prefix, uri in namespaces.items():
        ET.register_namespace(prefix, uri)

    ET.indent(root, space="  ")
    return ET.tostring(root, encoding="unicode", xml_declaration=False)


def main(input_url: str, output_path: str) -> None:
    print(f"Fetching index: {input_url}")
    index_root = fetch_rdf(input_url)

    desc_tag = f"{{{RDF}}}Description"
    descriptions = index_root.findall(desc_tag)

    # Separate the ConceptScheme from the concept stubs
    scheme_desc = None
    concept_urls: list[str] = []

    for desc in descriptions:
        if is_concept_scheme(desc):
            scheme_desc = desc
        else:
            about = desc.get(f"{{{RDF}}}about", "")
            if about:
                concept_urls.append(about)

    if scheme_desc is None:
        print("ERROR: no ConceptScheme found in index document", file=sys.stderr)
        sys.exit(1)

    print(f"Found ConceptScheme: {scheme_desc.get(f'{{{RDF}}}about')}")
    print(f"Found {len(concept_urls)} concept stubs to resolve")

    # Build the output rdf:RDF element
    namespaces = build_rdf_namespaces()
    for prefix, uri in namespaces.items():
        ET.register_namespace(prefix, uri)

    rdf_root = ET.Element(f"{{{RDF}}}RDF")

    # Add the ConceptScheme
    rdf_root.append(description_to_concept_scheme(scheme_desc))

    # Fetch and add each concept
    for url in sorted(concept_urls):
        print(f"  Fetching concept: {url}")
        full_desc = fetch_full_concept(url)
        if full_desc is not None:
            rdf_root.append(description_to_concept(full_desc))
        else:
            # Fallback: use the stub from the index
            for desc in descriptions:
                if desc.get(f"{{{RDF}}}about") == url:
                    rdf_root.append(description_to_concept(desc))
                    break

    # Serialize
    ET.indent(rdf_root, space="  ")
    xml_str = ET.tostring(rdf_root, encoding="unicode", xml_declaration=False)
    output = "<?xml version='1.0' encoding='utf-8'?>\n" + xml_str + "\n"

    with open(output_path, "w", encoding="utf-8") as f:
        f.write(output)

    print(f"\nWritten {output_path}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(__doc__)
        sys.exit(1)
    main(sys.argv[1], sys.argv[2])
