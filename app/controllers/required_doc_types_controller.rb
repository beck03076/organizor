class RequiredDocTypesController < ApplicationController
  # GET /required_doc_types
  # GET /required_doc_types.json
  def index
    @required_doc_types = RequiredDocType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @required_doc_types }
    end
  end

  # GET /required_doc_types/1
  # GET /required_doc_types/1.json
  def show
    @required_doc_type = RequiredDocType.find(params[:id])

    respond_to do |format|
      format.js
      format.html # show.html.erb
      format.json { render json: @required_doc_type }
    end
  end

  # GET /required_doc_types/new
  # GET /required_doc_types/new.json
  def new
    @required_doc_type = RequiredDocType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @required_doc_type }
    end
  end

  # GET /required_doc_types/1/edit
  def edit
    @required_doc_type = RequiredDocType.find(params[:id])
  end

  # POST /required_doc_types
  # POST /required_doc_types.json
  def create
    @required_doc_type = RequiredDocType.new(params[:required_doc_type])

    respond_to do |format|
      if @required_doc_type.save
        format.html { redirect_to required_doc_types_path, notice: 'Required doc type was successfully created.' }
        format.json { render json: @required_doc_type, status: :created, location: @required_doc_type }
      else
        format.html { render action: "new" }
        format.json { render json: @required_doc_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /required_doc_types/1
  # PUT /required_doc_types/1.json
  def update
    @required_doc_type = RequiredDocType.find(params[:id])

    respond_to do |format|
      if @required_doc_type.update_attributes(params[:required_doc_type])
        format.html { redirect_to required_doc_types_path, notice: 'Required doc type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @required_doc_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /required_doc_types/1
  # DELETE /required_doc_types/1.json
  def destroy
    @required_doc_type = RequiredDocType.find(params[:id])
    @required_doc_type.destroy

    respond_to do |format|
      format.html { redirect_to required_doc_types_url }
      format.json { head :no_content }
    end
  end
end
