describe('The multilingual functionality', () => {
  before(() => {
    cy.baseSetup()
  })

  beforeEach(() => {
    cy.visit('/')
    cy.login()
  })

  it('does not duplicate elements upon saving or navigating to other tabs', () => {
    cy.visit('/srv/eng/catalog.edit#/create')
    cy.get('a').contains('Generieke Open data, conform DCAT-AP VL v2.0').click()
    cy.get('button').contains('Create').click()
    // get the new metadata id from the location so we can query its xml content
    let hashRegexp = /^#\/metadata\/(\d+)\?.*/;
    cy.location('hash').should('match', hashRegexp).then((hash) => {
      const metadataId = +(hashRegexp.exec(hash)[1])
      expect(hash.startsWith("metadata"))
      expect(metadataId).to.be.a('number')
      expect(metadataId).to.be.at.least(1)
      // get the fresh record
      cy.request(`/srv/api/records/${metadataId}/formatters/xml`).then((response) => {
        cy.wrap(response.status).should('equal', 200)
        const originalXml = response.body
        // previously, multilingual elements were duplicated when clicking on the record tab (#132), now testing whether that is the case
        cy.get('li[role="menuitem"]').contains('Record').click()
        cy.get('input[value="DCAT-AP Vlaanderen"]')
        cy.intercept('POST', '/srv/api/records/*/editor*').as('saveRequest')
        cy.get('#gn-editor-btn-save').click()
        cy.wait('@saveRequest').its('response.statusCode').should('equal', 200)
        cy.request(`/srv/api/records/${metadataId}/formatters/xml`).then((secondResponse) => {
          const newXml = response.body
          sameCount(newXml, originalXml, 'NLD')
          sameCount(newXml, originalXml, 'dct:title')
        })
      })
    })
  })

  function sameCount(a: any, b: any, search: String) {
    expect(a.split(search).length).to.equal(b.split(search).length)
  }
})
