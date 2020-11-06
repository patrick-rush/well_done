class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
    skip_before_action :verify_authenticity_token, only: :facebook
    skip_before_action :verify_authenticity_token, only: :create
  
    def facebook
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env["omniauth.auth"])
  
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url
      end
    end
  
    def failure
      redirect_to root_path
    end

    # def facebook
    #   if current_user.present?
    #     current_user.apply_omniauth(request.env["omniauth.auth"])
    #     redirect_to edit_user_registration_path, notice: "Facebook Account Linked!"
    #   else
    #     @user = User.from_omniauth(request.env["omniauth.auth"])
    #     sign_in_and_redirect @user
    #   end
    # end

  end