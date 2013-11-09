class RolesController < ApplicationController
authorize_resource
 def show_permissions
   role = Role.find(params[:role_id])
   render partial: 'permissions',locals: {role: role }
 end

 def index

    @roles = Role.includes(:permissions).all.reject {|i| i.name == "agency_administrator"}
    
    respond_to do |format|
      format.html { }#render layout: "users" }
      format.json { render json: @roles }
    end
    
    
    
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    @permissions = @role.permissions.group_by &:subject_class
  end

  # GET /roles/new
  # GET /roles/new.json
  def new
    permissions
    @role = Role.new
    
    #render layout: "users"
  end

  # GET /roles/1/edit
  def edit
    permissions
  end

 def create
    @role = Role.new(params[:role])
    if @role.save
      msg= "Role created successfully!"
    else
      msg= "Role create failed!"
    end
    redirect_to roles_path, :flash => { :notice => msg }
  end

  # PUT /roles/1
  # PUT /roles/1.json
  def update
    @role = Role.find(params[:id])
    
    if @role.update_attributes(params[:role])
      msg= "Role updated successfully!"
    else
      msg= "Role update failed!"
    end
    redirect_to roles_path, :flash => { :notice => msg }
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy    
    @role = Role.find(params[:id])
    if @role.destroy
      msg= "Role deleted successfully!"
    else
      msg= "Role delete failed!"
    end
    redirect_to roles_path, :flash => { :notice => msg }
  end
  
  private
  
  def permissions
    @permissions = Permission.where('subject_class != ?',"All").group_by &:subject_class
  end
end
