describe('Sign Up form', () => {
    beforeEach(() => {
        cy.request('POST', '/testing/reset') // reset the test email
        cy.visit(`users/sign_up`)
    })

    it('registers a new user successfully', () => {
        cy.get('input#user_email').type('test@email.com')
        cy.get('input#user_password').type('test123')
        cy.get('input#user_password_confirmation').type('test123')
        cy.get('input').contains('Sign up').click()

        // Assert that user is at home page and sees welcome message
        cy.url().should('equal', 'http://localhost:3000/')
        cy.get('p.text-success').should('include.text', 'Welcome! You have signed up successfully.')
    })

    it('prevents invalid email address from submitting', () => {
        cy.get('input#user_email').type('test')
        cy.get('input#user_password').type('test123')
        cy.get('input#user_password_confirmation').type('test123')
        cy.get('input').contains('Sign up').click()

        // Assert that the email field is invalid
        cy.get('input#user_email').then(($input) => {
            expect($input[0].checkValidity()).to.be.false
            expect($input[0].validationMessage).to.include('@')
        })

        cy.url().should('include', '/users/sign_up')
    })

    it('rejects password less than 6 characters', () => {
        cy.get('input#user_email').type('test@email.com')
        cy.get('input#user_password').type('12345')
        cy.get('input#user_password_confirmation').type('12345')
        cy.get('input').contains('Sign up').click()

        cy.get('div#error_explanation').should('include.text', 'Password is too short (minimum is 6 characters)')
    })
})