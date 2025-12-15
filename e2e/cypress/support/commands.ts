// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add('login', (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add('drag', { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add('dismiss', { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite('visit', (originalFn, url, options) => { ... })

declare namespace Cypress {
  interface Chainable {
    acceptCookie(): Chainable<void>;

    login(): Chainable<void>;

    logout(): Chainable<void>;

    baseSetup(): Chainable<void>;
  }
}

Cypress.Commands.add('login', () => {
  cy.contains('Sign in').click();
  cy.get('#inputUsername').type('admin', {force: true});
  cy.get('#inputPassword').type('admin', {force: true});
  cy.get('button[type="submit"]').click();
});

Cypress.Commands.add('logout', () => {
  cy.get('a[title="User details"]').click();
  cy.get('a[title="Sign out"]').click();
})

Cypress.Commands.add('acceptCookie', () => {
  cy.get('.cookie-warning-actions').within(() => {
    cy.contains('Accept').click();
  })
});

Cypress.Commands.add('baseSetup', () => {
  if (Cypress.env('SETUP_DONE')) {
    return;
  }
  cy.task('resetDB');
  cy.visit('/srv/eng/catalog.search#/home');
  cy.acceptCookie();
  cy.login();
  cy.visit('/srv/eng/admin.console#/metadata');
  cy.contains('DCAT-AP (dcat-ap)').click();
  cy.contains('Load templates for selected standards').click();
  cy.contains("14 record(s) added for schema 'dcat-ap'.")
  cy.logout();
  Cypress.env('SETUP_DONE', true);
});

