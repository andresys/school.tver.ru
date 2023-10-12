class Methodic < ActiveRecord::Base
  attr_accessible :title, :teacher_ids, :full_title
  validates :title, :presence => true
  validates :full_title, :presence => true

  belongs_to :school

  has_many :teacher_methodic_link, :dependent => :delete_all
  has_many :teacher, :through => :teacher_methodic_link
  has_many :methodic_document, :through => :teacher
  
  accepts_nested_attributes_for :teacher_methodic_link, 
    :reject_if => lambda { |a| a[:teacher_id].blank? }, 
    :allow_destroy => true

  def size_of_doc()
    size = 0;
    self.teacher.each do |teacher|
      size = size + teacher.methodic_document.size
    end
    return size
  end
end
