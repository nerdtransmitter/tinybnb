class Home < ApplicationRecord
  belongs_to :user
  has_many :listings

  has_one_attached :photo

  validates :name, :address, :description, :price, presence: true

end
