class NewsLink < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :news, :link, :link_id, :link_type
  belongs_to :link, :polymorphic => true
  belongs_to :news
end
