module MyExtension
  extend ActiveSupport::Concern
  
  def initialize
      belongs_to :_ass_by, class_name: "User",foreign_key: "assigned_by"
      belongs_to :_ass_to, class_name: "User",foreign_key: "assigned_to"
      belongs_to :_cre_by, class_name: "User",foreign_key: "created_by"
      belongs_to :_upd_by, class_name: "User",foreign_key: "updated_by"
  end
  
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
  
  def _cby
    help_m(self.created_by)
  end
  
  def _uby
    help_m(self.updated_by)
  end
  
  def _ato
    help_m(self.assigned_to)
  end
  
  def _aby
    help_m(self.assigned_by)
  end
  
  def help(col)
    if col
     User.find(col).first_name rescue "Unknown"
    else
     "Unknown"
    end
  end 
  
  def help_m(col)
    if col
     User.find(col)
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
