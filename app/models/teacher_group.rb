class TeacherGroup < ActiveRecord::Base
  attr_accessible :title
  belongs_to :school
  has_many :teacher
  validates :title, :presence => true
end
