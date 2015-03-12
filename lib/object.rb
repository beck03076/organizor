class Object
  def try_chain(*args) 
    args.inject(self) do |result, method| 
      result.try(method)
    end
  end
end