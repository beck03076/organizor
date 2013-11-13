class YolksController < ApplicationController
  # GET /yolks
  # GET /yolks.json
  def index
    @yolks = Yolk.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @yolks }
    end
  end

  # GET /yolks/1
  # GET /yolks/1.json
  def show
    @yolk = Yolk.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @yolk }
    end
  end

  # GET /yolks/new
  # GET /yolks/new.json
  def new
    @yolk = Yolk.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @yolk }
    end
  end

  # GET /yolks/1/edit
  def edit
    @yolk = Yolk.find(params[:id])
  end

  # POST /yolks
  # POST /yolks.json
  def create
    @yolk = Yolk.new(params[:yolk])

    respond_to do |format|
      if @yolk.save
        format.html { redirect_to @yolk, notice: 'Yolk was successfully created.' }
        format.json { render json: @yolk, status: :created, location: @yolk }
      else
        format.html { render action: "new" }
        format.json { render json: @yolk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /yolks/1
  # PUT /yolks/1.json
  def update
    @yolk = Yolk.find(params[:id])

    respond_to do |format|
      if @yolk.update_attributes(params[:yolk])
        format.html { redirect_to @yolk, notice: 'Yolk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @yolk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yolks/1
  # DELETE /yolks/1.json
  def destroy
    @yolk = Yolk.find(params[:id])
    @yolk.destroy

    respond_to do |format|
      format.html { redirect_to yolks_url }
      format.json { head :no_content }
    end
  end
end
