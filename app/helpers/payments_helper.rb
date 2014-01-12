module PaymentsHelper
   def all_currencies(hash)
    hash.inject([]) do |array, (id, attributes)|
      array ||= []
      array << [attributes[:name], attributes[:iso_code]]
      array
    end.sort
  end
end
