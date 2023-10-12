class Photo < ActiveRecord::Base
	attr_accessible :image, :title, :description, :image_file_name
	has_attached_file :image, 
    :styles => { :big => "1024x768>", :medium => "300x300#", :thumb => "160x120#", :small => "80x80#"}
	
  belongs_to :parent_of_image, :polymorphic => true

  def url(what)
    return self.image.url(what)
  end
end