class Admin::RolesController < ApplicationController
  before_action :authenticate_admin
  layout "admin/application"

  def index
    @roles = Role.all.order("created_at desc")
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to admin_roles_path
    else
      render "new"
    end
  end

  def show
    @role = Role.find(params[:id])
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    @role.update_attributes(role_params)
    redirect_to admin_roles_path
  end

  def destroy
    @role = Role.find(params[:id]).destroy
    redirect_to admin_roles_path
  end

  private

  def role_params
    params.require(:role).permit!
  end
end
