class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_google(from_google_params)

    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private

  def from_google_params
    @from_google_params ||= {
      email: auth.info.email,
      full_name: auth.info.name,
      uid: auth.uid,
      avatar_url: auth.info.image #,
      # password: SecureRandom.urlsafe_base64,
      # first_name: auth.info.name.split(/ /).first,
      # last_name: auth.info.name.split(/ /).last
    }
    # binding.pry
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
    # def facebook
    #   # You need to implement the method below in your model (e.g. app/models/user.rb)
    #   @user = User.from_omniauth(request.env["omniauth.auth"])
  
    #   if @user.persisted?
    #     sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    #     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    #   else
    #     session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
    #     redirect_to new_user_registration_url
    #   end
    # end
  
    # def failure
    #   redirect_to root_path
    # end

    # def facebook
    #   if current_user.present?
    #     current_user.apply_omniauth(request.env["omniauth.auth"])
    #     redirect_to edit_user_registration_path, notice: "Facebook Account Linked!"
    #   else
    #     @user = User.from_omniauth(request.env["omniauth.auth"])
    #     sign_in_and_redirect @user
    #   end
    # end

  # end