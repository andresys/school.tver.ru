# coding: utf-8
class User < ActiveRecord::Base
  default_scope :order => 'username ASC'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :username, :username_permission, :locked
  belongs_to :school

  validates :username, :presence => true
  validates :email, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/,:message => "Недопустимый email"}
  #validates_presence_of :email, 
  # attr_accessible :title, :body
  def active_for_authentication?
    super && !self.locked
  end
end
