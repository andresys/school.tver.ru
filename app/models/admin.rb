# coding: utf-8
class Admin < ActiveRecord::Base
  default_scope :order => 'admin_name ASC'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable,  
         :trackable, 
         :validatable,
         :rememberable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, 
    :remember_me, :admin_name, :locked
  # attr_accessible :title, :body
  validates :admin_name, :presence => true
  validates :email, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/,:message => "Недопустимый email"}
  def active_for_authentication?
    super && !self.locked
  end
end
