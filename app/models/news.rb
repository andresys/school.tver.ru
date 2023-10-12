class News < ActiveRecord::Base
  default_scope :order => 'news_date DESC'
  attr_accessible :body, :description, :title, :youtube,
    :achiev_school, :achiev_section, :achiev_teacher, :achiev_pupil, 
    :document_attributes, :simply_link_attributes, 
    :photo_attributes, :teacher_ids, :section_ids, :news_date

  validates :title, :presence => true
  validates :body, :presence => true
  validates :news_date, :presence => true
  validates :description, :presence => true
  validates :youtube, :format => { :with => /(youtu\.be\/([^\?]*))|(^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*)/ }, :allow_blank => true

  belongs_to :school

  has_many :simply_link, :as => :parent_link_page
  has_many :photo, :as => :parent_of_image, :dependent => :destroy
  has_many :document, :as => :parent_page, :dependent => :destroy

  has_many :news_link, :dependent => :destroy
  has_many :teacher, :through => :news_link, :source => :link, 
    :source_type => "Teacher"
  has_many :section, :through => :news_link, :source => :link, 
    :source_type => "Section"

  accepts_nested_attributes_for :photo, :reject_if => lambda { |a| a[:image].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :document, :reject_if => lambda { |a| a[:file].blank? && a[:title].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :simply_link, :reject_if => lambda { |a| a[:link_url].blank? }, :allow_destroy => true

  accepts_nested_attributes_for :news_link, :allow_destroy => true

  
  #validates :youtube, :inclusion => { :in => %w(youtube watch)}

  #before_save :check_youtube

  #def check_youtube
  #  if !self.youtube.blank?
  #    self.youtube.include
  #  end
  #end
end
