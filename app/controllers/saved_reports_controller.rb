class SavedReportsController < ApplicationController
  # GET /saved_reports
  # GET /saved_reports.json
  def index
    @saved_reports = SavedReport.where(created_by: current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @saved_reports }
    end
  end

  # GET /saved_reports/1
  # GET /saved_reports/1.json
  def show
    @saved_report = SavedReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @saved_report }
    end
  end

  # GET /saved_reports/new
  # GET /saved_reports/new.json
  def new
    @saved_report = SavedReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @saved_report }
    end
  end

  # GET /saved_reports/1/edit
  def edit
    @saved_report = SavedReport.find(params[:id])
  end

  # POST /saved_reports
  # POST /saved_reports.json
  def create
    @saved_report = SavedReport.new(params[:saved_report])

    respond_to do |format|
      if @saved_report.save
        format.html { redirect_to saved_reports_url, notice: 'Saved report was successfully created.' }
        format.json { render json: @saved_report, status: :created, location: @saved_report }
      else
        format.html { render action: "new" }
        format.json { render json: @saved_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /saved_reports/1
  # PUT /saved_reports/1.json
  def update
    @saved_report = SavedReport.find(params[:id])

    respond_to do |format|
      if @saved_report.update_attributes(params[:saved_report])
        format.html { redirect_to saved_reports_url, notice: 'Saved report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @saved_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saved_reports/1
  # DELETE /saved_reports/1.json
  def destroy
    @saved_report = SavedReport.find(params[:id])
    @saved_report.destroy

    respond_to do |format|
      format.html { redirect_to saved_reports_url }
      format.json { head :no_content }
    end
  end
end
