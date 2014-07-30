class AddDeviseIndexToRegistrations < ActiveRecord::Migration
  def change
    add_index :registrations, :email1, unique: true
    add_index :registrations, :reset_password_token, unique: true
    add_index :registrations, :confirmation_token,   unique: true    
  end
end
