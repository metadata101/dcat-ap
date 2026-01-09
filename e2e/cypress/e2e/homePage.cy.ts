describe('Check homepage', () => {
  before(() => {
    cy.visit('/srv/eng/catalog.search#/home')
  })

  it('Display the footer', () => {
    cy.get('footer').contains('Powered by GeoNetwork')
  })
})
