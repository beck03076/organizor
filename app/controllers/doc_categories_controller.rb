class DocCategoriesController < ApplicationController
  authorize_resource
  # GET /doc_categories
  # GET /doc_categories.json
  def index
    @doc_categories = DocCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @doc_categories }
    end
  end

  # GET /doc_categories/1
  # GET /doc_categories/1.json
  def show
    @doc_category = DocCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @doc_category }
    end
  end

  # GET /doc_categories/new
  # GET /doc_categories/new.json
  def new
    @doc_category = DocCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @doc_category }
    end
  end

  # GET /doc_categories/1/edit
  def edit
    @doc_category = DocCategory.find(params[:id])
  end

  # POST /doc_categories
  # POST /doc_categories.json
  def create
    @doc_category = DocCategory.new(params[:doc_category])

    respond_to do |format|
      if @doc_category.save
        format.html { redirect_to doc_categories_path, notice: 'Doc category was successfully created.' }
        format.json { render json: @doc_category, status: :created, location: @doc_category }
      else
        format.html { render action: "new" }
        format.json { render json: @doc_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /doc_categories/1
  # PUT /doc_categories/1.json
  def update
    @doc_category = DocCategory.find(params[:id])

    respond_to do |format|
      if @doc_category.update_attributes(params[:doc_category])
        format.html { redirect_to doc_categories_path, notice: 'Doc category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @doc_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doc_categories/1
  # DELETE /doc_categories/1.json
  def destroy
    @doc_category = DocCategory.find(params[:id])
    @doc_category.destroy

    respond_to do |format|
      format.html { redirect_to doc_categories_url }
      format.json { head :no_content }
    end
  end
end
