class SimplyLink < ActiveRecord::Base
  attr_accessible :link_title, :link_url
  attr_accessible :parent_link_page

  belongs_to :parent_link_page, :polymorphic => true

  validates :link_title, :presence => true
  validates :link_url, :presence => true

  before_save :normalize_link

  def normalize_link
    self.link_url = ("http://" + self.link_url) if 
          self.link_url.match(/^.+\:\/\/.+$/).nil?
  end

end
