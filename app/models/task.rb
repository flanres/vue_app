class Task < ApplicationRecord
  validates :name, presence: true
  validates :name,    length: { in: 1..75 }
  validates :is_done, inclusion: { in: [true, false] }
end
