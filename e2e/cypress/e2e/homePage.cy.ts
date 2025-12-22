describe('Check homepage', () => {
  before(() => {
    cy.baseSetup();
    cy.visit('/srv/eng/catalog.search#/home');
  });

  it('Display the footer', () => {
    cy.contains('The catalog currently contains no information.');
  });
});
