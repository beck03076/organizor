class JsonController < ApplicationController

  def srch_countries
    @countries = Country.where("name like ?", "%#{params[:q]}%")
    
      respond_to do |format|
        format.html
        format.json { render :json => @countries.map(&:attributes) }
      end
  end
  
  def srch_regions
    @regions = Region.where("name like ?", "%#{params[:q]}%")
    
      respond_to do |format|
        format.html
        format.json { render :json => @regions.map(&:attributes) }
      end
  end

  def cities
  
    set_url_params    
    country = Country.find(@co_id)
    if @type == "simple"
       @cities = country.cities.includes(:institutions)
    else
       @cities = country.cities.includes(:institutions).where("institutions.id is not null").order("cities.name")    
    end
    
    
    respond_to do |format|
      format.html 
      format.json { render json: @cities }
    end
    
  end

  def institutions
    set_url_params
    if @geo == "city"
      city = City.find(@c_id)
      @institutions = city.institutions.where(type_id: @ins_type_id)
    elsif @geo == "country"
      country = Country.find(@c_id)
      @institutions = country.institutions.where(type_id: @ins_type_id)
    end
    
    respond_to do |format|
      format.html 
      format.json { render json: @institutions }
    end
  end
  
  def institution_type
    set_url_params
    
    @institutions = InstitutionType.find(@type_id).institutions

    respond_to do |format|
      format.html 
      format.json { render json: @institutions }
    end
  end
  
  def pre(p_type = 1,co = nil,ci = nil)
    @countries = self.basic_select(Country)
    if !co.nil? && !ci.nil?      
      country = Country.find(co)
      @cities = self.basic_select(country.cities)
      city = City.find(ci)
      @institutions = self.basic_select(city.institutions,{:type_id => p_type})
    elsif !co.nil?     
      country = Country.find(co)
      @cities = self.basic_select(country.cities)
      @institutions = []
    elsif co.nil?       
      @cities = []
      @institutions = []
    end  
    @p_types = ProgrammeType.all
    @c_levels = self.basic_select(CourseLevel)
  end
  
 
end
