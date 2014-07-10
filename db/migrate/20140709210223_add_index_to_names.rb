class AddIndexToNames < ActiveRecord::Migration
  def change
  	[:enquiries,:registrations,:people].each do |model|
  	  add_index model,:first_name
    end
  end
end
