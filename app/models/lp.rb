class Lp < ApplicationRecord
  belongs_to :artist
  validates :name, presence: true, length: { maximum: 70 }
  validates :description, presence: true, length: { maximum: 300 }
end
