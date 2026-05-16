class Task < ApplicationRecord
  enum :status, { 
    new: 0,
    in_progress: 1,
    done: 2,
    cancelled: 3
  }, prefix: true

  validates :title, presence: true
  validates :status, presence: true
  validates :description, presence: true
  validates :exec_date, presence: true
end
