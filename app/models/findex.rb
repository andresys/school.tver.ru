class Findex < ActiveRecord::Base
  self.table_name = "findex"

  attr_accessible :file

  has_attached_file :file, {
    use_timestamp: false,
    url: '/school/:school/food/findex.:extension',
    path: ':rails_root/public/system/findex/:school/findex.:extension',
    hash_secret: "a6onjUVAksylpNPftiRfBVNbgndizqB07kFU9upvcyf0IKYpkYNcvbRhiWWXMndZxOzlQBRCJNNGj01XmV/W2/Qo192QF+f4glnw0dOYKMeVTd8CSOyc+HS1pSIGWy17L8JsxVRetkmNNDW74lvkKDC+BKXoIda7FmFQvYtqQkk="
  }

  validates :file_file_name, :presence => true

  belongs_to :school

private
  Paperclip.interpolates :school  do |file, style|
    file.instance.school.permalink
  end
end
