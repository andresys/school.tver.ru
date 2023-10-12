class SchoolIndexImage < ActiveRecord::Base
  attr_accessible :image, :title, :body, :image_file_name
  has_attached_file :image, :styles => { :medium => "568x257#", :small => "80x35#"}
  belongs_to :school
  before_save :check_title
  validates :image_file_name, :presence => true
  # def url(what)
  #   return self.image.url(what)
  # end
  # attr_accessible :title, :body
  def check_title
    if self.title.blank?
      self.title = self.image_file_name
    end
  end
  
  def check_params
    return (self.title.blank? || self.image_file_name.blank?)
  end

end
