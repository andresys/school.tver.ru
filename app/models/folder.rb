class Folder < ActiveRecord::Base
  include ActsAsTree
  attr_accessible :title, :parent_id, :school_id
  validates :title, :presence => true
  validates_uniqueness_of :title, :scope => [:school_id]
  belongs_to :school
  acts_as_tree order: "id"
  has_many :document, :as => :parent_page, :dependent => :destroy

  def parent_list
  	val = []
  	temp = self
  	while !temp.parent.nil?
  		val+=[temp.parent]
  		temp = temp.parent
  	end
  	return val.reverse
  end

end
