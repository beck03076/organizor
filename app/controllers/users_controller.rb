class UsersController < ApplicationController
  include ActionsMethods
  helper_method :meta

  def link
    @user = User.find(params[:id])
  end
  
  def log
    @user = User.find(params[:id])
    @audits = Audit.where(user_id: params[:id]).order("created_at desc")
    @log = true
  end

  # authorize_resource
  # GET /users
  # GET /users.json
  def index
    if params[:f_id].present?
      @users = params[:model].camelize.constantize.find(params[:f_id]).users
    else
      @users = User.order(:first_name)
    end
    authorize! :list, @users, id: current_user.id

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.js
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if params[:id].nil?
        @user = current_user
    else
        @user = User.includes(:permissions).find(params[:id])
    end    
   # authorize! :read, @user, id: current_user.id
    @show = true
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new

    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end

  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    authorize! :update, @user, id: current_user.id
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    authorize! :create, User

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    authorize! :update, @user, id: current_user.id
=begin
    # on actually updating an users role, you also have to update the users permissions, because roles are just templates of permissions
    if !params[:user].nil?
      if params[:user][:role_id]
        p = Role.find(params[:user][:role_id]).permissions.map &:id
        params[:user][:permission_ids] = p
      end
    else
      params[:user] = {:permission_ids => []}
    end
=end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user, id: current_user.id
    @user.destroy
    Timeline.where(user_id: @user.id).delete_all

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
