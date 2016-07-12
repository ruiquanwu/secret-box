class User < ActiveRecord::Base
  enum role: [:normal, :admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :diaries
  has_many :albums
  has_many :orders
end
