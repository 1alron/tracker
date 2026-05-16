class Task < ApplicationRecord
  enum status: [ :new, :in_progress, :done, :cancelled ]

  validates :title, presence: true
  validates :status, presence: true
  validates :description, presence: true
  validates :exec_date, presence: true
end
