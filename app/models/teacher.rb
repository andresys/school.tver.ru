class Teacher < ActiveRecord::Base
  attr_accessible :surname, :name, :experience, :about_teacher, 
    :contact, :clafication, :photo, :delete_photo, :post, 
    :teacher_group, :teacher_group_id, :methodic_document_attributes, :achiev

  validates :surname, :presence => true
  validates :name, :presence => true
  validates :experience, :presence => true
  validates :clafication, :presence => true
  validates :post, :presence => true
  
  belongs_to :teacher_group

  has_many :section, :through => :teacher_section_link
  has_many :teacher_section_link, :dependent => :delete_all
 
  has_many :methodic, :through => :teacher_methodic_link
  has_many :teacher_methodic_link, :dependent => :delete_all
  
  has_many :methodic_document
  has_many :news_link, :as => :link, :dependent => :destroy
  has_many :news, :through => :news_link
 
  has_attached_file :photo, :styles => { :big => "1024x768>", :medium => "78x96#", 
    :thumb => "155x233#", :index => "160x197#", :methodic => "108x133#"},
    :default_url => "default/teacher/:style/missing.jpg"
  attr_accessor :delete_photo

  accepts_nested_attributes_for :news_link, :allow_destroy => true
  accepts_nested_attributes_for :methodic_document, :reject_if => lambda { |a| a[:file].blank? && a[:title].blank? }, :allow_destroy => true

  before_validation { photo.clear if delete_photo == '1' }

  default_scope order('surname ASC')

  def check_title
    if self.title.blank?
      self.title = self.file_file_name
    end
  end

  def get_name()
    return self.surname + " " + self.name
  end
end
