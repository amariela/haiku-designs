describe('Log In Form', () => {
    beforeEach(() => {
        cy.visit(`users/sign_in`)
    })

    it('allows existing user to log in successfully', () => {
        cy.get('input[type=email]').type('bob@builder.com')
        cy.get('input[type=password').type('bobthebuilder')
        cy.get('input[type=submit]').contains('Log in').click()

        cy.get('div.alert-success').should('include.text', 'Signed in successfully.')
        cy.get('span.nav-link.disabled').should('include.text', 'Hello, bob@builder.com!')
    })

    it('displays error message when incorrect email is used', () => {
        cy.get('input[type=email]').type('bob@test.com')
        cy.get('input[type=password').type('bobthebuilder')
        cy.get('input[type=submit]').contains('Log in').click()

        cy.get('div.alert-danger').should('include.text', 'Invalid Email or password.')
        cy.url().should('include', '/users/sign_in')
    })

    it('displays error message when incorrect password is used', () => {
        cy.get('input[type=email]').type('bob@builder.com')
        cy.get('input[type=password').type('testing')
        cy.get('input[type=submit]').contains('Log in').click()

        cy.get('div.alert-danger').should('include.text', 'Invalid Email or password.')
        cy.url().should('include', '/users/sign_in')
    })
})