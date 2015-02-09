module MyExtension
  extend ActiveSupport::Concern

  def _cr_by
    User.find(self.created_by).first_name
  end

  def try_chain(*args) 
    args.inject(self) do |result, method| 
      result.try(method)
    end
  end

  module ClassMethods
  # nothing yet
    def bar
    end
  end
end

ActiveRecord::Base.send(:include, MyExtension)

