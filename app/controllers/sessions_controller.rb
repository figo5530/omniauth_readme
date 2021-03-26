class SessionsController < ApplicationController
    def create
        @user = User.find_or_create_by(name: fb_auth['info']['name']) do |u|
            u.password = 'password'
        end
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end

    def destroy
        session.clear
        redirect_to '/'
    end

    private
    def fb_auth
        self.request.env['omniauth.auth']
    end
end