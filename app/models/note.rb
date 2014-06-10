class Note < ActiveRecord::Base
  include ActionsModel

  require 'redcarpet'
  belongs_to :noteable, polymorphic: true
  belongs_to :registration
  belongs_to :institution
  belongs_to :programme
  attr_accessible :content,:auto

  notifiably_audited alert_for: [[:polymorphic,nil,:content,[:noteable_type,:noteable_id]]]
  
  def safe_content
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
    :autolink => true, :space_after_headers => true)
    markdown.render(self.content).html_safe
    
  end

end
