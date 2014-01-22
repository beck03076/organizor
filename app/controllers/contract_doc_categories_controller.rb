class ContractDocCategoriesController < ApplicationController
  authorize_resource
  # GET /contract_doc_categories
  # GET /contract_doc_categories.json
  def index
    @contract_doc_categories = ContractDocCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contract_doc_categories }
    end
  end

  # GET /contract_doc_categories/1
  # GET /contract_doc_categories/1.json
  def show
    @contract_doc_category = ContractDocCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contract_doc_category }
    end
  end

  # GET /contract_doc_categories/new
  # GET /contract_doc_categories/new.json
  def new
    @contract_doc_category = ContractDocCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contract_doc_category }
    end
  end

  # GET /contract_doc_categories/1/edit
  def edit
    @contract_doc_category = ContractDocCategory.find(params[:id])
  end

  # POST /contract_doc_categories
  # POST /contract_doc_categories.json
  def create
    @contract_doc_category = ContractDocCategory.new(params[:contract_doc_category])

    respond_to do |format|
      if @contract_doc_category.save
        format.html { redirect_to contract_doc_categories_path, notice: 'Contract doc category was successfully created.' }
        format.json { render json: @contract_doc_category, status: :created, location: @contract_doc_category }
      else
        format.html { render action: "new" }
        format.json { render json: @contract_doc_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contract_doc_categories/1
  # PUT /contract_doc_categories/1.json
  def update
    @contract_doc_category = ContractDocCategory.find(params[:id])

    respond_to do |format|
      if @contract_doc_category.update_attributes(params[:contract_doc_category])
        format.html { redirect_to contract_doc_categories_path, notice: 'Contract doc category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contract_doc_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contract_doc_categories/1
  # DELETE /contract_doc_categories/1.json
  def destroy
    @contract_doc_category = ContractDocCategory.find(params[:id])
    @contract_doc_category.destroy

    respond_to do |format|
      format.html { redirect_to contract_doc_categories_url }
      format.json { head :no_content }
    end
  end
end
