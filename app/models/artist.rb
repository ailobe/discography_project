class Artist < ApplicationRecord
  has_many :lps, dependent: :destroy
  validates :name, presence: true, length: { maximum: 70 }
  validates :description, presence: true, length: { maximum: 300 }
end
