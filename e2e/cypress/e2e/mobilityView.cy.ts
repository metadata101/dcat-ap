describe('The mobilityDCAT-AP view', () => {
  before(() => {
    cy.baseSetup()
  })

  it('displays some of the expected content', () => {
    cy.login()
    // load the view using the xsl-view formatter (which is based on the editor-config)
    cy.visit('/srv/eng/catalog.search#/metadata/d2e57ef8-2bff-41bd-b2ff-3ceb90dc4dd9/formatters/xsl-view')
    // check content (to be completed)
    cy.get('a').contains('workplace homepage 1')
    cy.get('a').contains('keyword1')
    cy.get('a').contains('https://w3id.org/mobilitydcat-ap/mobility-theme/accidents-and-incidents')
    cy.get('a').contains('https://w3id.org/mobilitydcat-ap/network-coverage/tern-network')
  })
})
