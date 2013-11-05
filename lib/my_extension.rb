module MyExtension
  extend ActiveSupport::Concern

  def tname
    self.name.titleize rescue "Unknown"
  end

  def cby
    help(self.created_by)
  end
  
  def uby
    help(self.updated_by)
  end
  
  def ato
    help(self.assigned_to)
  end
  
  def aby
    help(self.assigned_by)
  end
  
  def help(col)
    if col
     User.find(col).first_name
    else
     "Unknown"
    end
  end 
  
  module ClassMethods
  # nothing yet
    def bar
    end
  end
end

ActiveRecord::Base.send(:include, MyExtension)
