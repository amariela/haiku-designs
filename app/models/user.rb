class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  belongs_to :role

  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role = Role.find_by(name: "customer")
  end
end
