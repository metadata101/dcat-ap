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
    acceptCookie(): Chainable<void>

    api(method: string, url: string, user: Object, acceptedStatusCodes: number[]): Chainable<Response<any>>

    baseSetup(): Chainable<void>

    login(): Chainable<void>

    logout(): Chainable<void>

    reindex(): Chainable<void>

    isIndexing(): Chainable<boolean>
  }
}

type User = {
  username: string
  password: string
}

const testUsers = {
  admin: {
    username: 'admin', password: 'admin'
  }
}

Cypress.Commands.add('login', () => {
  cy.contains('Sign in').click()
  cy.get('#inputUsername').type(testUsers.admin.username, {force: true})
  cy.get('#inputPassword').type(testUsers.admin.password, {force: true})
  cy.get('button[type="submit"]').click()
})

Cypress.Commands.add('logout', () => {
  cy.get('a[title="User details"]').click()
  cy.get('a[title="Sign out"]').click()
})

Cypress.Commands.add('acceptCookie', () => {
  cy.get('.cookie-warning-actions').within(() => {
    cy.contains('Accept').click()
  })
})

Cypress.Commands.add('api', (method: string, url: string, user: User, acceptedStatusCodes: number[]) => {
  cy.getCookie('XSRF-TOKEN')
    .should('have.property', 'value')
    .then((xsrfToken) => {
      return cy.request({
        method: method,
        url: url,
        auth: {
          username: user.username,
          password: user.password
        },
        headers: {
          "X-XSRF-TOKEN": xsrfToken,
          'Accept': 'application/json'
        },
        failOnStatusCode: false
      })
    })
    .then((response) => {
      console.log('api response (' + url + '): ' + response.status)
      cy.wrap(response.status).should('be.oneOf', acceptedStatusCodes)
      return cy.wrap(response)
    })
})

Cypress.Commands.add('isIndexing', () => {
  cy.api("GET", '/srv/api/site/indexing', testUsers.admin, [200])
    .then((response) => {
      cy.wrap(response.body==="true")
    })
})

Cypress.Commands.add('reindex', () => {
  // asynchronous=true indicates (weirdly) we wait until index has finished
  cy.api("PUT", "/srv/api/site/index?reset=true&asynchronous=true", testUsers.admin, [200])
})

Cypress.Commands.add('baseSetup', () => {
  if (Cypress.env('SETUP_DONE')) {
    return
  }
  cy.task('resetDB')
  cy.visit('/srv/eng/catalog.search#/home')
  cy.acceptCookie()
  cy.login()
  cy.visit('/srv/eng/admin.console#/metadata')
  cy.contains('DCAT-AP (dcat-ap)').click()
  cy.contains('Load templates for selected standards').click()
  cy.contains("14 record(s) added for schema 'dcat-ap'.")
  cy.reindex()
  cy.logout()
  Cypress.env('SETUP_DONE', true)
})

