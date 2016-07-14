class User < ActiveRecord::Base
  enum role: [:normal, :admin]
  after_initialize :set_default_role, :if => :new_record?
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :diaries
  has_many :albums
  has_many :orders
  
  def set_default_role
    self.role ||= :normal
  end
end
