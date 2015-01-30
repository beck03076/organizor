class AddIndexToForeignKeys < ActiveRecord::Migration
  def change
    [:enquiries,:registrations,:partners,:people].each do |model|
      [:assigned_to,:assigned_by,:created_by,:updated_by,:country_id].each do |i|
         add_index  model,i
      end
    end
  end
end
