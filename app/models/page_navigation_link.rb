# coding: utf-8
class PageNavigationLink < ActiveRecord::Base
  default_scope :order => "number DESC"
  attr_accessible :link, :number, :default, :title
  belongs_to :page_group
  has_one :static_page,  :dependent => :destroy
  # validates :link, :presence => true
  # validates :number, :presence => true
  before_create :add_number

  def get_last_update
    if !self.static_page.blank?
      if !self.static_page.body.blank?
        return self.static_page.updated_at
      else
        return ''
      end
    end
    
    if self.page_group.school_id.blank?
      return ''
    end

    case link
      when 'folders'
        if !self.page_group.school.folder.blank?
          return self.page_group.school.folder.last.updated_at
        else
          ''
        end
      when 'media_links'
        if !self.page_group.school.media_link.last.blank?
          return self.page_group.school.media_link.last.updated_at
        else
          ''
        end
      when 'sponsors'
        if !self.page_group.school.sponsor.last.blank?
          return '__'
        else
          ''
        end
      when 'methodics'
        if !self.page_group.school.methodic.last.blank?
          return '__'
        else
          ''
        end
      when 'methodic_documents'
        if !self.page_group.school.methodic_document.last.blank?
          return self.page_group.school.methodic_document.last.updated_at
        else
          ''
        end
      when /^security/
        return '__'
    end

  end

  private
    def add_number
      number = -1
      group = PageGroup.find_all_by_content_type(self.page_group.content_type)
      page = group.first
      if page
        number = page.number
      end
      self.number = number+1
    end
end
