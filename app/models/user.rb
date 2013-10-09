class User < ActiveRecord::Base
  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
                  :remember_me,:branch_id, :created_by, 
                  :email_signature, :image, :role_id, 
                  :updated_by,:first_name,:surname

  def name
    (self.first_name.to_s + ' ' + self.surname.to_s).titleize.strip
  end
end
