class RequiredDocsController < ApplicationController
  authorize_resource
  # GET /required_docs
  # GET /required_docs.json
  def index
    @required_docs = RequiredDoc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @required_docs }
    end
  end

  # GET /required_docs/1
  # GET /required_docs/1.json
  def show
    @required_doc = RequiredDoc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @required_doc }
    end
  end

  # GET /required_docs/new
  # GET /required_docs/new.json
  def new
    @required_doc = RequiredDoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @required_doc }
    end
  end

  # GET /required_docs/1/edit
  def edit
    @required_doc = RequiredDoc.find(params[:id])
  end

  # POST /required_docs
  # POST /required_docs.json
  def create
    @required_doc = RequiredDoc.new(params[:required_doc])

    respond_to do |format|
      if @required_doc.save
        format.html { redirect_to required_docs_path, notice: 'Required doc was successfully created.' }
        format.json { render json: @required_doc, status: :created, location: @required_doc }
      else
        format.html { render action: "new" }
        format.json { render json: @required_doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /required_docs/1
  # PUT /required_docs/1.json
  def update
    @required_doc = RequiredDoc.find(params[:id])

    respond_to do |format|
      if @required_doc.update_attributes(params[:required_doc])
        format.html { redirect_to required_docs_path, notice: 'Required doc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @required_doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /required_docs/1
  # DELETE /required_docs/1.json
  def destroy
    @required_doc = RequiredDoc.find(params[:id])
    @required_doc.destroy

    respond_to do |format|
      format.html { redirect_to required_docs_url }
      format.json { head :no_content }
    end
  end
end
