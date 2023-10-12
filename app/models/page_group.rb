class PageGroup < ActiveRecord::Base
  default_scope :order => "number DESC"
  attr_accessible :title, :content_id, :content_type, :image_file_name, 
    :image, :number, :default,  :content_type, :image, :published

  validates :title, :presence => true
  validates :content_type, :inclusion => { :in => %w(about training health)}
  belongs_to :content, :polymorphic => true
  belongs_to :school
  
  has_many :static_page, :through => :page_navigation_link
  has_many :page_navigation_link,  :dependent => :destroy

  has_attached_file :image, :styles => { :size => "218x126#" },
    :default_url => "default/page_groups/:styles/missing.png"

  before_create :add_number

  validates :number, :uniqueness => { :scope => :content_type }, :on => :create
  #validates :number, :title => { :scope => :content_type }

  def create_static_page(title, default=false)
    link = self.page_navigation_link.create(:title => title, :default => default)
    page = StaticPage.create(:title => title, :page_navigation_link_id => link.id, :default => default)
    link.link = "static_pages/#{page.id}"
    link.save
  end

  def create_link(title, link, default=true)
    self.page_navigation_link.create(:title => title, :link => link, :default => default)
  end

  private
    def add_number
      number = -1
      group = PageGroup.where(:content_type => self.content_type, :school_id => self.school_id).first
      if group
        number = group.number
      end
      self.number = number+1
    end

end
