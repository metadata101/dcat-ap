describe('Check homepage', () => {
  before(() => {
    cy.visit('/srv/dut/catalog.search#/home');
  });

  it('Display the footer', () => {
    cy.contains('Browse by');
  });
});
