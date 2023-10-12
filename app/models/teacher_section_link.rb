class TeacherSectionLink < ActiveRecord::Base
  # attr_accessible :title, :body
  # attr_accessible :teacher_id, :section_id
  belongs_to :teacher
  belongs_to :section
end
