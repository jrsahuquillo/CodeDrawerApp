class CallbacksController < Devise::OmniauthCallbacksController

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    flash[:success] = "Welcome! You have signed up successfully."
    sign_in_and_redirect @user
  end
end