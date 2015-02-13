class PartnersController < ApplicationController
  include CoreController
  include ActionsMethods
  helper_method :meta
  skip_before_filter :authenticate_user!, only: [:action_partial]

  def tab
    set_url_params
    self.set_cols
    render partial: @partial
  end

  def action_partial
    set_url_params

    if @partial_name == "finance"
      # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.pro_cols
      b = [:start_date]
      @cols = ((b & a) + (a - b))
    end

    #called from CoreMethods
    h_action_partial("partner",
                     params[:partner_id],
                     ["contract","people","finance","students","documents"])

  end

  # h_new stands for help_new
  def h_new

  end

  # GET /partners
  # GET /partners.json
  def index
    authorize! :list, Partner

    set_url_params
    self.set_cols
    @tab_type ||= "PartnerType"

    set_tab_value

    respond_to do |format|
      format.html # index.html.erb
      format.json { core_json("partner",nil,@tab_type) } # in core_methods
      format.js { core_js("partner",nil,@tab_type) } # in core_methods
      format.select { render json: Partner.all }
    end
  end

  # GET /partners/1
  # GET /partners/1.json
  def show
    @partner = Partner.find(params[:id])
    authorize! :read, @partner
    # showing basic by default
    @partial = "basic"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @partner }
    end
  end

  # GET /partners/new
  # GET /partners/new.json
  def new
    @partner = Partner.new(type_id: PartnerType.first.id,assigned_to: current_user.id,assigned_by: current_user.id)
    authorize! :create, @partner
    @partner.contracts.build
  end

  def clone
    # To have this next line, is to display the enquiry name on the tab, thats all
    @partner = Partner.find(params[:id])
    authorize! :create, @partner
  end

  # GET /partners/1/edit
  def edit
    @partner = Partner.find(params[:id])
    authorize! :update, @partner
  end

  # POST /partners
  # POST /partners.json
  def create
    @partner = Partner.new(params[:partner])

    respond_to do |format|
      if @partner.save
        format.html { redirect_to @partner, notice: 'Partner was successfully created.' }
        format.json { render json: @partner, status: :created, location: @partner }
      else
        format.html { render action: "new" }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /partners/1
  # PUT /partners/1.json
  def update
    @partner = Partner.find(params[:id])


    respond_to do |format|
      if @partner.update_attributes(params[:partner].except("assign","_destroy"))
        format.html { redirect_to @partner, notice: 'Partner was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /partners/1
  # DELETE /partners/1.json
  def destroy
    @partner = Partner.find(params[:id])
    authorize! :destroy, @partner
    @partner.destroy

    respond_to do |format|
      format.html { redirect_to partners_url }
      format.json { head :no_content }
    end
  end

  def set_cols
    # a is the cols chosen stored in the database and b are the right order of cols
      a = current_user.conf.ins_cols
      b = [:id,:name,:email,:phone]
      @cols = ((b & a) + (a - b)) + [:follow_up_date]
  end
end
