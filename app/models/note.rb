class Note < ActiveRecord::Base
  require 'redcarpet'
  belongs_to :enquiry  
  belongs_to :registration
  belongs_to :institution
  belongs_to :programme
  attr_accessible :content, :sub_class, :sub_id
  
  def safe_content
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
    :autolink => true, :space_after_headers => true)
    markdown.render(self.content).html_safe
    
  end

end
