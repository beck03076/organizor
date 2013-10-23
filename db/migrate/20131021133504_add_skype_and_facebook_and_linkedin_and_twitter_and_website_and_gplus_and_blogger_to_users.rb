class AddSkypeAndFacebookAndLinkedinAndTwitterAndWebsiteAndGplusAndBloggerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :skype, :string
    add_column :users, :facebook, :string
    add_column :users, :linkedin, :string
    add_column :users, :twitter, :string
    add_column :users, :website, :string
    add_column :users, :gplus, :string
    add_column :users, :blogger, :string
  end
end
