class Devise::ConfirmationsController < DeviseController

   layout 'user'
  # GET /resource/confirmation/new
  def new
    @cart = current_cart
    @email = params[:email]
    build_resource({})
  end

  # POST /resource/confirmation
  def create
    @cart = current_cart
    self.resource = resource_class.send_confirmation_instructions(params[resource_name])

    if successfully_sent?(resource)
      #respond_with({}, :location => after_resending_confirmation_instructions_path_for(resource_name))
      redirect_to static_site_index_path
    else
      respond_with(resource)
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    @cart = current_cart
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
    end
  end

  protected

    # The path used after resending confirmation instructions.
    def after_resending_confirmation_instructions_path_for(resource_name)
      new_session_path(resource_name)
    end

    # The path used after confirmation.
    def after_confirmation_path_for(resource_name, resource)
      after_sign_in_path_for(resource)
    end

end
