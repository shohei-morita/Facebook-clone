class Picture < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { in: 1..50 }
  validates :content, presence: true, length: { in: 1..350 }
end
