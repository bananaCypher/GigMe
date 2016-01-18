class UserMailer < ApplicationMailer
    default from: 'notifications@gigbanana.com'

    def welcome_email(user)
        @user = user
        @url = 'http://localhost:3000/users/sign_in'
        mail(to: @user.email, subject: 'Welcome to Gigbanana')
    end


    def reciept_email(user, items, total)
        @user = user
        @items = items
        @total = total
        mail(to: @user.email, subject: 'Booking reciept')
    end
end
