class JsonController < ApplicationController

  def student_sources   
    @student_sources = ContactType.find(params[:contact_type_id]).student_sources   
    respond_to do |format|
      format.json { render json: @student_sources }
    end

  end
  
  def currency
    set_url_params
    if @country_id.to_i != 0
      @currency = [Country.find(@country_id).currency]
    end
    respond_to do |format|
      format.html 
      format.json { render json: @currency }
    end
  end

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
       @cities = country.cities.includes(:partners)
    else
       @cities = country.cities.includes(:partners).where("partners.id is not null").order("cities.name")    
    end
    
    
    respond_to do |format|
      format.html 
      format.json { render json: @cities }
    end
    
  end

  def partner_types 
   
    @types = PartnerCategory.find(params[:id]).try(:partner_types)
    
    respond_to do |format|
      format.html 
      format.json { render json: @types }
    end
    
  end

  def partners
    set_url_params
    if @country_id.to_i != 0
      @partners = Country.find(@country_id).partners
    end
    if @city_id.to_i != 0
      @partners = @partners.blank? ? Partner : @partners
      @partners = @partners.where(city_id: @city_id)
    end
    if @ins_type_id.to_i != 0 && (@country_id.to_i != 0 || @city_id.to_i != 0)
      @partners = @partners.blank? ? Partner : @partners
      @partners = @partners.where(type_id: @ins_type_id)
    end

    respond_to do |format|
      format.html 
      format.json { render json: @partners.order(:name) }
    end
  end
  
  def partner_type
    set_url_params
    
    @partners = PartnerType.find(@type_id).partners

    respond_to do |format|
      format.html 
      format.json { render json: @partners }
    end
  end
  
  def pre(p_type = 1,co = nil,ci = nil)
    @countries = self.basic_select(Country)
    if !co.nil? && !ci.nil?      
      country = Country.find(co)
      @cities = self.basic_select(country.cities)
      city = City.find(ci)
      @partners = self.basic_select(city.partners,{:type_id => p_type})
    elsif !co.nil?     
      country = Country.find(co)
      @cities = self.basic_select(country.cities)
      @partners = []
    elsif co.nil?       
      @cities = []
      @partners = []
    end  
    @p_types = ProgrammeType.all
    @c_levels = self.basic_select(CourseLevel)
  end
 
 def get_users
   set_url_params
   @users = User.where('branch_id = ?', @branch_id).order(:first_name)
    respond_to do |format|
      format.html 
      format.json { render json: @users }
    end   
 end
end
