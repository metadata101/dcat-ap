describe('Admin tools', () => {
  before(() => {
    cy.baseSetup();
  });

  it('Can reindex', () => {
    cy.login()
    // intercept the indexing request for later, so we can inspect when it's finished
    cy.intercept('PUT', '/srv/api/site/index?reset=true&asynchronous=true').as('indexRequest')
    // click the 'reindex' button
    cy.visit('/srv/eng/admin.console#/tools')
    cy.get('button').contains('Delete index and reindex').click()
    // wait till the call has returned, this should be synchronous
    cy.wait('@indexRequest').its('response.statusCode').should('eq', 200)
    // at this point geonetwork should not indicate an active indexing process anymore
    cy.isIndexing().should('be.false')
  });
});
