class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  # юзкер может создавать много событий
  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true,
                   length: {maximum: 35}

  before_validation :set_name, on: :create

  private

  def set_name
    # self.name = "Товарисч №#{rand(999)}" if self.name.blank?
    self.name
  end
end
