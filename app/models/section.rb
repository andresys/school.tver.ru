class Section < ActiveRecord::Base
  attr_accessible :body, :count, :title, :year, :image, 
    :photo_attributes, :document_attributes, :simply_link_attributes, 
    :type_of_section, 
    :teacher_section_link, :teacher_section_link_attributes, 
    :teacher_ids, :description, :delete_image

  validates :title, :presence => true
  validates :description, :presence => true
  validates :year, :presence => true, 
    :length => { :minimum => 4, :maximum => 4 }
  validates :count, :presence => true
  validates :body, :presence => true

  belongs_to :school

  has_many :teacher, :through => :teacher_section_link
  has_many :teacher_section_link, :dependent => :delete_all
  has_many :simply_link, :as => :parent_link_page
  has_many :photo, :as => :parent_of_image, :dependent => :destroy
  has_many :document, :as => :parent_page, :dependent => :destroy
  has_many :news_link, :as => :link, :dependent => :destroy
  has_many :news, :through => :news_link

  has_attached_file :image, :styles => { :medium => "160x120#" },
    :default_url => "default/section/missing.png"
  before_validation { image.clear if delete_image == '1' }
  attr_accessor :delete_image

  accepts_nested_attributes_for :photo, :reject_if => lambda { |a| a[:image].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :teacher_section_link, :reject_if => lambda { |a| a[:teacher_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :document, :reject_if => lambda { |a| a[:file].blank? && a[:title].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :simply_link, :reject_if => lambda { |a| a[:link_url].blank? }, :allow_destroy => true


end
