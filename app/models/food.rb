class Food < ActiveRecord::Base
  default_scope :order => 'date DESC'
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

  def self.menu_types
    [
      { id: 0, name: 'обычное меню' },
      { id: 1, name: 'меню для младших классов', suffix: 'sm' }
    ]
  end

  def self.get_by_menufilename(school, menufilename)
    year, month, day, menu_type = menufilename.scan(/(\d{4})-(\d{2})-(\d{2})-?([a-zA-Z0-9]+)?/).first
    date = Date::strptime("#{year}-#{month}-#{day}", "%Y-%m-%d")
    menu_type = Food.menu_types.select{|mt| mt[:suffix] == menu_type }
    menu_type = menu_type && menu_type.first[:id] || 0
    school.food.find_by_date_and_menu_type(date, menu_type)
  end

  def title
    "#{get_menu_type && get_menu_type[:name] || menu_type} от #{Russian::strftime(date, "%d %B %Y")}".mb_chars.capitalize.to_s
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
    mt = Food.menu_types.select{|mt| mt[:id] == menu_type }
    mt && mt.first
  end

  def get_file_ext
    ext = File.extname(file_file_name)
    ext = ext.gsub(/[^0-9A-Za-z]/, '')
  end

  def menufilename
    suffix = get_menu_type && get_menu_type[:suffix]
    "#{date.strftime('%F')}#{suffix && '-'+suffix}"
  end

private
  Paperclip.interpolates :menufilename  do |file, style|
    file.instance.menufilename
  end

  Paperclip.interpolates :school  do |file, style|
    file.instance.school.permalink
  end
end
