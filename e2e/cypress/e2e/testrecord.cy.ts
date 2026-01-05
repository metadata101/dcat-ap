describe('The test record', () => {
  before(() => {
    cy.baseSetup();
  });

  beforeEach(() => {
    cy.visit('/')
    cy.login()
    cy.visit('/srv/eng/catalog.search#/metadata/345f47ef-abd5-4f2f-9ab7-d723565cccea')
  });

  it('displays expected values in the view', () => {
    cy.get('h1').contains('dataset title')
    cy.get('button').contains('custom keyword 1')
    cy.get('button').contains('Cultuur en sport')
  });

  it.only('is not modified unexpectedly by the editor', () => {
    function cleanXml(xml: string) {
      return xml.replace(/<dct:modified>.+?<\/dct:modified>/g, '')
    }

    cy.visit('/srv/eng/catalog.search#/metadata/345f47ef-abd5-4f2f-9ab7-d723565cccea');
    cy.request('/srv/api/records/345f47ef-abd5-4f2f-9ab7-d723565cccea/formatters/xml').then((response) => {
      expect(response.status).to.be.equal(200);
      const originalXml = cleanXml(response.body);
      cy.get('.gn-md-edit-btn').click()
      cy.get('label').contains('Other identifier')
      cy.get('#gn-editor-btn-close').click()
      cy.location('pathname').should('match', /^\/srv\/eng\/catalog.search/)
      cy.request('/srv/api/records/345f47ef-abd5-4f2f-9ab7-d723565cccea/formatters/xml').then((secondResponse) => {
        expect(secondResponse.status).to.be.equal(200);
        const newXml = cleanXml(secondResponse.body)
        console.log('new xml')
        console.log(newXml)
        console.log('original xml')
        console.log(originalXml)
        expect(newXml).to.equal(originalXml)
      });
    })
  })
});
