module MyExtension
  extend ActiveSupport::Concern

  def _cr_by
    User.find(self.created_by).first_name
  end

  module ClassMethods
  # nothing yet
    def bar
    end
  end
end

ActiveRecord::Base.send(:include, MyExtension)
