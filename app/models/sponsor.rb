class Sponsor < ActiveRecord::Base
  attr_accessible :sponsor_type, :sponsor_url, :title
  validates :title, :presence => true
  belongs_to :school
end
