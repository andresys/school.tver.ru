class AnnounceToParent < ActiveRecord::Base
  default_scope :order => 'news_date DESC'
  attr_accessible :body, :description, :title, :youtube,
    :document_attributes, :simply_link_attributes, :photo_attributes, :news_date

  validates :title, :presence => true
  validates :body, :presence => true
  validates :description, :presence => true
  validates :news_date, :presence => true
  validates :youtube, :format => { :with => /(youtu\.be\/([^\?]*))|(^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*)/ }, :allow_blank => true

  belongs_to :school
 
  # Dynamic content from news_module
  has_many :simply_link, :as => :parent_link_page
  has_many :photo, :as => :parent_of_image, :dependent => :destroy
  has_many :document, :as => :parent_page, :dependent => :destroy

  accepts_nested_attributes_for :photo, 
    :reject_if => lambda { |a| a[:image].blank? }, 
    :allow_destroy => true
  accepts_nested_attributes_for :document, 
    :reject_if => lambda { |a| a[:file].blank? && a[:title].blank? }, 
    :allow_destroy => true
  accepts_nested_attributes_for :simply_link, 
    :reject_if => lambda { |a| a[:link_url].blank? }, 
    :allow_destroy => true

end
