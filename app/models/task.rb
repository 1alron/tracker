class Task < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  enum :status, { 
    new: 0,
    in_progress: 1,
    done: 2,
    cancelled: 3
  }, prefix: true, validate: true

  validates :title, presence: true
  validates :status, presence: true
  validates :description, presence: true
  validates :exec_date, presence: true
end
