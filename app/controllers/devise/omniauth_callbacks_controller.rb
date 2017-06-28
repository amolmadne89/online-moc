class Devise::OmniauthCallbacksController < DeviseController
  skip_before_action :verify_authenticity_token
  def failure
    set_flash_message :alert, :failure, :kind => failed_strategy.name.to_s.humanize, :reason => failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end

  def facebook
    # You need to implement the method below in your model
#    raise request.env["omniauth.auth"]["credentials"]["token"].to_yaml
    logger.info request.env["omniauth.auth"].inspect
    logger.info current_user.inspect
    @user, @newuser = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    logger.info @user.inspect
    if @user.persisted?
      add_user_id_to_productcompare
      add_user_id_to_wishlist
      session[:first_time] = true if @newuser
      if session[:valentine_contest_user].present?
        @valentine_entry = ValentineEntry.find(session[:valentine_contest_user]) rescue nil
        @valentine_entry.update_column("user_id", @user.id) rescue nil
        if ValentineEntry.where(:user_id => @user.id).count == 1
          #post on user wall
          @valentine_entry.delay.post_on_users_wall
        end
      end
      session[:fb_token] = request.env["omniauth.auth"]["credentials"]["token"] if request.env["omniauth.auth"]['provider'] == 'facebook'
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      if session[:valentine_contest_user].present?
        sign_in @user, :event => :authentication
        session[:valentine_contest_user] = nil
        redirect_to parent_collections_url(:name => "valentine-special") #for valentine contest
      else
        session[:facebook_login_user] = true
        sign_in_and_redirect @user, :event => :authentication
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    user = User.where(:provider => request.env["omniauth.auth"].provider, :uid => request.env["omniauth.auth"].uid).first
#    if user.present?
#      session['retrn'] = user.tags.blank? ? session[:retrn] : session[:retrn].split('?').first
#    end
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      add_user_id_to_productcompare
      add_user_id_to_wishlist
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in @user#, :event => :authentication
      redirect_to after_sign_in_path_for(@user)
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
	end
  
  protected

  def failed_strategy
    env["omniauth.error.strategy"]
  end

  def failure_message
    exception = env["omniauth.error"]
    error   = exception.error_reason if exception.respond_to?(:error_reason)
    error ||= exception.error        if exception.respond_to?(:error)
    error ||= env["omniauth.error.type"].to_s
    error.to_s.humanize if error
  end

  def after_omniauth_failure_path_for(scope)
    new_session_path(scope)
  end
end
