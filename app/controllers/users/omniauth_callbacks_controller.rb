class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def memair
    @user = User.from_memair_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in(:user, @user)
      if @user.twitter_access_token.nil?
        redirect_to user_twitter_omniauth_authorize_path
      else
        flash[:notice] = 'Successfully logged'
        redirect_to root_path
      end
    else
      session['devise.memair_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def twitter
    current_user.update(
      twitter_access_token: request.env['omniauth.auth']['extra'].access_token.token,
      twitter_access_token_secret: request.env['omniauth.auth']['extra'].access_token.secret,
      twitter_uid: request.env['omniauth.auth']['uid']
    )
    redirect_to root_path
  end
end
