class MediaLink < ActiveRecord::Base
  attr_accessible :title, :url, :date_public, :url_source

  validates :title, :presence => true
  validates :url, :presence => true
  validates :url_source, :presence => true

  belongs_to :school
end
