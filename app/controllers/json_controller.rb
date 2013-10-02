class JsonController < ApplicationController

  def cities
  
    set_url_params
    country = Country.find(@co_id)
    @cities = country.cities
    
    respond_to do |format|
      format.html 
      format.json { render json: @cities }
    end
    
  end

  def institutions
    set_url_params
    if @geo == "city"
      city = City.find(@c_id)
      @institutions = city.institutions.where(type_id: @p_type_id)
    elsif @geo == "country"
      country = Country.find(@c_id)
      @institutions = country.institutions.where(type_id: @p_type_id)
    end
    
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
