describe('Check homepage', () => {
  before(() => {
    cy.visit('/');
  });

  it('Display the footer', () => {
    cy.contains('Browse by');
  });
});
