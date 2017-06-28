class Devise::PasswordsController < DeviseController
  layout 'materialuser'
  # prepend_before_filter :require_no_authentication
  skip_before_filter :verify_authenticity_token, :only => :create

  # GET /resource/password/new
  def new
    @cart = current_cart
    self.resource = resource_class.new
  end

  # POST /resource/password
  def create
    @cart = current_cart
    @home_sliders = HomeSlider.find(:all, :order => 'preference_no DESC')
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      @error = 0
     #respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
      render :action => "forgot_password"
      
    else
      @error = 1
      #flash_message = "#{resource.email} is not a registered email address"
      #set_flash_message(:notice, flash_message)
      #:flash => { :error => 'Enter valid email or password' }
      render :action => "forgot_password"
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    @cart = current_cart
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
  end

  # PUT /resource/password
  def update
    @cart = current_cart 
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_in_path_for(resource)
    else
      respond_with resource
    end
  end

  protected

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      new_session_path(resource_name)
    end

end
