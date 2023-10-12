# coding: utf-8
class School < ActiveRecord::Base
  attr_accessible :description, :mailto, :title, :emblem, :text_about_page, :type_of_school, :form_of_training, :school_index_image_attributes, :pos_id
  #has_one :type_of_school
  attr_accessible :address, :phones, :other_contact, 
    :document_attributes, :sponsor_attributes, 
    :permalink, :district_id, :delete_emblem,
    :n_cordinate, :e_cordinate, :existing_site,
    :vk, :facebook, :twitter
  belongs_to :district
  has_many :form_of_training

  validates :title, :presence => true
  validates :phones, :length => { :maximum => 250 }
  validates_uniqueness_of :permalink
  validates_format_of :permalink, :with => /^([a-z]|[0-9])+$/
  validates :permalink, :presence => true, 
    :uniqueness => true
    #:format => { :with => /^([A-Z]|[0-9]|[a-z])+$/ } 
  validates :n_cordinate, :presence => true
  validates :e_cordinate, :presence => true
  # validates :description, :presence => true, :length => { :minimum => 5 }
  has_many :asset, :dependent => :destroy
  has_many :methodic, :dependent => :destroy
  has_many :users, :dependent => :destroy
  has_many :media_link, :dependent => :destroy
  has_many :page_group, :dependent => :destroy
  has_many :static_page, :through => :page_group, :dependent => :destroy
  has_many :creation, :dependent => :destroy
  has_many :announcement, :dependent => :destroy
  has_many :announce_to_parent, :dependent => :destroy
  has_many :news, :dependent => :destroy
  has_many :section, :dependent => :destroy
  has_many :teacher_group, :dependent => :destroy
  has_many :teacher, :through => :teacher_group
  has_many :methodic_document, :through => :teacher
  has_many :school_index_image
  has_many :simply_link, :as => :parent_link_page
  has_many :document, :as => :parent_page, :dependent => :destroy
  has_many :folder, :dependent => :destroy
  has_many :sponsor, :dependent => :destroy
  has_many :food, :dependent => :destroy
  has_one  :findex, :dependent => :destroy
  accepts_nested_attributes_for :document, :reject_if => lambda { |a| a[:file].blank? && a[:title].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :sponsor, :allow_destroy => true
  accepts_nested_attributes_for :school_index_image, :reject_if => lambda { |a| a[:image].blank? && a[:title].blank? }, :allow_destroy => true

  # Герб школы
  has_attached_file :emblem, 
    :styles => { :medium => "37x44#", :thumb => "13x16#" },
    :default_url => "default/emblems/:style/missing.png"
  before_validation { emblem.clear if delete_emblem == '1' }
  attr_accessor :delete_emblem

  after_create :create_static_pages
  before_create :n_cordinate_blank
  before_create :e_cordinate_blank
  before_save :normalize_link

  def normalize_link
    if !self.existing_site.blank?
      self.existing_site = ("http://" + self.existing_site) if 
            self.existing_site.match(/^.+\:\/\/.+$/).nil?
    end
    if !self.vk.blank?
      self.vk = ("http://" + self.vk) if 
            self.vk.match(/^.+\:\/\/.+$/).nil?
    end
    if !self.facebook.blank?
      self.facebook = ("http://" + self.facebook) if 
            self.facebook.match(/^.+\:\/\/.+$/).nil?
    end
    if !self.twitter.blank?
      self.twitter = ("http://" + self.twitter) if 
            self.twitter.match(/^.+\:\/\/.+$/).nil?
    end
  end

  def n_cordinate_blank
    if self.n_cordinate.blank?
      self.n_cordinate= 56.85
    end
  end

  def e_cordinate_blank
    if self.e_cordinate.blank?
      self.e_cordinate= 35.89
    end
  end

  def string_to_sort
    # ext = ext.gsub(/[^0-9A-Za-z]/, '')
    return self.title.gsub(/[^0-9]/, '').to_i
  end


  def create_static_pages
    # Сведения от образовательно организации
    group = self.page_group.create( :title => "Организация питания в образовательной организации",
      :content_type => 'about',
      :image => File.new('app/assets/images/default/page_group/h_op.jpg', "r"),
      :default => true)
    # group.create_link("Ежедневное меню горячего питания", 'food', true)
    # group.create_static_page("Локальные акты", true)

    # group = self.page_group.create( :title => "Нормативная информация",
    #     :content_type => 'about',  
    #     :image => File.new('app/assets/images/default/page_group/a_ni.jpg', "r"),
    #     :default => true)
    # group.save
    # group.create_link("Документы", 'folders', true)
    # group.create_static_page("Образовательные программы", true)
    # group.create_static_page("Финансовые средства", true)
    # group.create_static_page("Материально-техническое обеспечение", true)

    # group = self.page_group.create( :title => "Знакомство со школой", 
    #     :content_type => 'about', 
    #     :image => File.new('app/assets/images/default/page_group/a_fs.jpg', "r"),
    #     :default => true)
    # group.create_static_page("История", true)
    # group.create_link("Упоминания в СМИ", 'media_links', true)
    # group.create_link("Спонсоры и партнеры", 'sponsors', true)


    # Обучение
    group = self.page_group.create( :title => "Наши разработки", 
        :content_type => 'training',
        :image => File.new('app/assets/images/default/page_group/t_od.jpg', "r"),
        :default => false)
    group.create_link("Методические объединения", 'methodics', false)
    group.create_link("Методические материалы", 'methodic_documents', false)
    group.create_static_page("Инновации в учебном процессе", false)
    group.create_static_page("Информатизация", false)

    group = self.page_group.create( :title => "Дополнительно",
        :content_type => 'training', 
        :image => File.new('app/assets/images/default/page_group/t_ad.jpg', "r"),
        :default => false)
    group.create_static_page("Подготовка к ЕГЭ", false)
    group.create_static_page("Факультативные занятия", false)
    group.create_static_page("Продленка", false)
    group.create_static_page("Библиотека", false)
    group.create_static_page("Компьютерный класс", false)

    group = self.page_group.create( :title => "Особенности обучения",
        :content_type => 'training', 
        :image => File.new('app/assets/images/default/page_group/t_os.jpg', "r"),
        :default => false)
    group.create_static_page("Методика обучения", false)
    group.create_static_page("Начальная школа", false)
    group.create_static_page("Основная школа", false)
    group.create_static_page("Средняя школа", false)
    group.create_static_page("Профильное обучение", false)

    group = self.page_group.create( :title => "Будущим ученикам",
        :content_type => 'training',  
        :image => File.new('app/assets/images/default/page_group/t_fp.jpg', "r"),
        :default => false)
    group.create_static_page("Дошкольная подготовка", false)
    group.create_static_page("Как поступить", false)
    group.create_static_page("Стоимость обучения", false)




    # Здоровье и сервис
    group = self.page_group.create( :title => "Медицина",
        :content_type => 'health',
        :image => File.new('app/assets/images/default/page_group/h_me.jpg', "r"),
        :default => false)
    group.create_static_page( "Кабинет здоровья", false)
    group.create_static_page( "Психолог", false)
    group.create_static_page( "Логопед", false)

    group = self.page_group.create( :title => "Сервис", 
        :content_type => 'health',
        :image => File.new('app/assets/images/default/page_group/h_se.jpg', "r"),
        :default => false)
    group.create_static_page("Бассейн", false)
    group.create_static_page("Тренажерный зал", false)
    group.create_static_page("Столовая", false)
    group.create_static_page("Безопасность", false)
    group.create_static_page("Школьный автобус", false)

    # Информационная безопасность
    group = self.page_group.create( :title => "Информационная безопасность",
        :content_type => 'health',
        :image => File.new('app/assets/images/default/page_group/h_ib.jpg', "r"),
        :default => true)
    group.create_link("Детские безопасные сайты", 'security/detskiye-bezopasnyye-sayty', true)
    group.create_link("Родителям", 'security/roditelyam', true)
    group.create_link("Ученикам", 'security/uchenikam', true)
    group.create_link("Педагогам", 'security/pedagogam', true)
    group.create_link("Нормативное регулирование", 'security/normativnoye-regulirovaniye', true)
    group.create_static_page("Локальные акты", true)

    self.teacher_group.create( :title => "Сотрудники") 
    self.teacher_group.create( :title => "Учителя") 
    self.teacher_group.create( :title => "Руководство")

    self.folder.create(:title => 'Документы')
  end
 
  def to_param
    permalink
  end

  def get_last_news(count)
    return (self.news.first(count)+
      self.creation.first(count)+
      self.announce_to_parent.first(count)).sort_by(&:news_date).last(count).reverse
  end

  def get_info()
    [self.permalink, self.n_cordinate, self.e_cordinate, self.title, self.address, self.phones, self.existing_site].to_json
  end

  def migrate_to_folder
    folder = self.folder.create(:title => 'Документы')
    self.document.each do |doc|
      doc.parent_page = folder
      doc.save
    end
  end



end
