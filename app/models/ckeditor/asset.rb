class Ckeditor::Asset < ActiveRecord::Base
  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Ckeditor::Backend::Paperclip
  attr_accessible :school
  belongs_to :school
  before_create :add_school_id

  def add_school_id
    if !self.assetable.blank?
      self.school_id = self.assetable.school.id
    else
      self.school_id = 0
    end
  end
end
