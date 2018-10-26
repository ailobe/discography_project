class Lp < ApplicationRecord
  belongs_to :artist
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 255 }
end
