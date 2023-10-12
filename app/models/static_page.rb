class StaticPage < ActiveRecord::Base
  default_scope :order => "number DESC"
  attr_accessible :body, :title
  attr_accessible :photo, :document, :simply_link, :news_link
  attr_accessible :document_attributes, :simply_link_attributes, 
    :photo_attributes, :page_navigation_link_id, :default, :number, :title
#  attr_accessible :body, :title, :content_id, :content_type
  #belongs_to :content, :polymorphic => true
  has_many :page_link, :as => :parent_page
  belongs_to :page_navigation_link
 # belongs_to :static_page_group, :through => :page_navigation_link
  validates :title, :presence => true
 
  has_many :simply_link, :as => :parent_link_page
  has_many :photo, :as => :parent_of_image, :dependent => :destroy
  has_many :document, :as => :parent_page, :dependent => :destroy

  accepts_nested_attributes_for :photo, :reject_if => lambda { |a| a[:image].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :document, :reject_if => lambda { |a| a[:file].blank? && a[:title].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :simply_link, :reject_if => lambda { |a| a[:link_url].blank? }, :allow_destroy => true

  def page_group
    return self.page_navigation_link.page_group
  end
end
