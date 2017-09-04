class Admin::UsersController < ApplicationController
  before_action :authenticate_admin
  layout "admin/application"

  def index
    @users = User.where(role_id: 4).where(branch_id: current_user.branch_id).order("created_at desc")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save(:validate => false)
      @user.update_column(:role, params[:role].values.last)
      if params[:role].values.last != "mobile_user"
        @user.update_columns(:company_name => "#{current_user.company_name}", :code => "#{current_user.code}")
      end
      redirect_to admin_users_path
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    @user.save(:validate => false)
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find(params[:id]).destroy
    redirect_to admin_users_path
  end

  # def user_wise_shifts
  #   @users = User.where("role =? and created_by =?", 'mobile_user', current_user.code).order("created_at desc")
  # end

  # def import_users
  #   User.import(params[:file])
  #   redirect_to admin_users_path, notice: "Users imported."
  # end

  private

  def user_params
    params.require(:user).permit!
  end
end
