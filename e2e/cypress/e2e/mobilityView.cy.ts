describe('The mobilityDCAT-AP view', () => {
  before(() => {
    cy.baseSetup()
  })

  it('displays some of the expected content', () => {
    cy.login()
    // load the view using the xsl-view formatter (which is based on the editor-config)
    cy.visit('/srv/eng/catalog.search#/metadata/d2e57ef8-2bff-41bd-b2ff-3ceb90dc4dd9/formatters/xsl-view?root=div&view=default')
    // check content (to be completed)
    cy.get('td').contains('MobilityDCAT-AP test record').siblings('th').contains('Title')
    cy.get('td').contains('Description of MobilityDCAT-AP test record').siblings('th').contains('Description')
    cy.get('td').contains('Publisher 1 name').siblings('th').contains('Name')

    cy.get('td').contains('https://w3id.org/mobilitydcat-ap/releases/1.1.0/').siblings('th').contains('Identifier')
    cy.get('td').contains('https://joinup.ec.europa.eu/collection/semic-support-centre/solution/dcat-application-profile-data-portals-europe/release/200').siblings('th').contains('Identifier')
  })
})
