class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_permissions

    def actions

    end

    private
    def check_permissions
        raise CanCan::AccessDenied if !current_user.role? :admin
    end
end
