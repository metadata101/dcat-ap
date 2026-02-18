describe('The mobilityDCAT-AP view', () => {
  before(() => {
    cy.baseSetup()
  })

  it('displays some of the expected content', () => {
    cy.login()
    // load the view using the xsl-view formatter (which is based on the editor-config)
    cy.visit('/srv/eng/catalog.search#/metadata/d2e57ef8-2bff-41bd-b2ff-3ceb90dc4dd9')
    // check content (to be completed)
    cy.get('h1').contains('MobilityDCAT-AP test record')
    cy.contains('Description of MobilityDCAT-AP test record')
    cy.get('button').contains('Accidents and incidents')
    cy.get('button').contains('Trans-European Road Network (TERN)')
  })
})
