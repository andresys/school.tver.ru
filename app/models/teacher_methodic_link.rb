class TeacherMethodicLink < ActiveRecord::Base
  #attr_accessible :title
  belongs_to :teacher
  belongs_to :methodic
end
