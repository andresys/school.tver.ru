require 'food_type'

class Food < ActiveRecord::Base
  default_scope :order => 'date DESC, updated_at DESC'
  attr_accessible :date, :file, :menu_type

  has_attached_file :file, {
    use_timestamp: false,
    url: '/school/:school/food/:menufilename.:extension',
    path: ':rails_root/public/system/:class/:school/:hash.:extension',
    hash_secret: "a6onjUVAksylpNPftiRfBVNbgndizqB07kFU9upvcyf0IKYpkYNcvbRhiWWXMndZxOzlQBRCJNNGj01XmV/W2/Qo192QF+f4glnw0dOYKMeVTd8CSOyc+HS1pSIGWy17L8JsxVRetkmNNDW74lvkKDC+BKXoIda7FmFQvYtqQkk="
  }

  validates :file_file_name, :presence => true
  validates :menu_type, :presence => true
  validates :date, :presence => true

  belongs_to :school

  after_initialize lambda {FoodType.current = FoodType.all.select {|mt| mt.types.map(&:id).include? menu_type}.first.slug}

  def self.get_by_menufilename(school, menufilename)
    type, year, month, day, suffix = menufilename.scan(/([a-zA-Z0-9]+)?(\d{4})-?(\d{2})?-?(\d{2})?-?([a-zA-Z0-9]+)?/).first
    case type
    when 'tm'
      p menu_type = FoodType.all.select{|mt| mt.slug == :typical}.first.types.select{|t| t.suffix == suffix }.map(&:id)
      school.food.where('extract(year  from date) = ?', year).find_by_menu_type(menu_type)
    else
      menu_type = FoodType.all.select{|mt| mt.slug == :daily}.first.types.select{|t| t.suffix == suffix }.map(&:id)
      date = Date::strptime("#{year}-#{month}-#{day}", "%Y-%m-%d")
      school.food.find_by_date_and_menu_type(date, menu_type)
    end
  end

  def title
    "#{get_menu_type.name} от #{Russian::strftime(date, "%d %B %Y")}".mb_chars.capitalize.to_s
  end

  def icon_for(options={})
    ext = File.extname(file_file_name)
    ext = ext.gsub(/[^0-9A-Za-z]/, '')
    if File.exists?(Rails.root+"app/assets/images/file_icons/#{get_file_ext}.png")
      return "file_icons/#{get_file_ext}.png"
    else
      return "file_icons/unknown.png"
    end
  end

  def small_icon_for(options={})
    if File.exists?(Rails.root+"app/assets/images/file_icons/small/#{get_file_ext}.png")
      return "file_icons/small/#{get_file_ext}.png"
    else
      return "file_icons/small/unknown.png"
    end
  end

  def get_menu_type
    FoodType.all.select {|mt| mt.types.map(&:id).include? menu_type}.first
  end

  def get_file_ext
    ext = File.extname(file_file_name)
    ext = ext.gsub(/[^0-9A-Za-z]/, '')
  end

  def menufilename
    get_menu_type.types.select {|t| t.id == menu_type}.first.filename.call(date)
  end

private
  Paperclip.interpolates :menufilename  do |file, style|
    file.instance.menufilename
  end

  Paperclip.interpolates :school  do |file, style|
    file.instance.school.permalink
  end
end
