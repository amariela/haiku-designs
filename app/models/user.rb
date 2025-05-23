class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  validates :email,
    format: { with: Devise.email_regexp },
    presence: true,
    uniqueness: { case_insensitive: true }
  belongs_to :role
  has_one :shipment, dependent: :destroy
  has_many :orders

  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role = Role.find_by(name: "customer")
  end
end
