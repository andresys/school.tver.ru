class MethodicDocument < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :description, :title, :file, :date, :teacher_id
#  attr_accessible :photo_page
  has_attached_file :file

  validates :file_file_name, :presence => true
  validates :title, :presence => true
  validates :date, :presence => true

  belongs_to :teacher

  before_save :check_title
  #has_attached_file :file, :styles => { :thumb => "48x48#" }

  def icon_for(options={})
    # ext = self.file_file_name.match(/[.](\w{1,6})\Z/)[1]
    # size = "#{options[:size]}/" if options[:size]
    # Rails.logger.debug(self.file.content_type )
    # # if !(self.file.content_type.to_s['image'])
    #   return "file_icons/#{size ||=""}#{ext}.png"
    # # else
    #   # return file.url(:thumb)
    # # end

    ext = File.extname(file_file_name)
    ext = ext.gsub(/[^0-9A-Za-z]/, '')
    if File.exists?(Rails.root+"app/assets/images/file_icons/#{ext}.png")
      return "file_icons/#{ext}.png"
    else
      return "file_icons/unknown.png"
    end
  end

  def small_icon_for(options={})
    ext = File.extname(file_file_name)
    ext = ext.gsub(/[^0-9A-Za-z]/, '')
    if File.exists?(Rails.root+"app/assets/images/file_icons/small/#{ext}.png")
      return "file_icons/small/#{ext}.png"
    else
      return "file_icons/small/unknown.png"
    end
  end
  def check_title
    if self.title.blank?
      self.title = self.file_file_name
    end
  end

  def check_params
    return (self.title.blank? || self.file_file_name.blank?)
  end

end
