class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
         
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'admin_id', dependent: :destroy
end
