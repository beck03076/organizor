class Currency < ActiveRecord::Base
  attr_accessible :code, :country_id, :country_name, 
  :iso_alpha2, :iso_alpha3, :iso_numeric, 
  :name, :symbol
  
  belongs_to :country
  
  def id
    self.code
  end
  
  def _name
    self.country_name + " " + self.name
  end
  

  def as_json(options={})
    {
      name: _name,
      id: iso_numeric
    }
  end
  
end
