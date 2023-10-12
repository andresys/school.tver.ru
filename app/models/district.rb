class District < ActiveRecord::Base
  attr_accessible :title
  validates :title, :presence => true
  has_many :school

  def get_sort_school
    self.school.where(archive: false).sort {|a, b| a.string_to_sort <=> b.string_to_sort}
  end
end
