class Tag < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tasks, through: :task_tags

  validates :name, presence: true

  PROTECTED_TAGS  = ["отчетность", "операции", "звонок"].freeze

  before_destroy :prevent_protected_deletion

  def as_json(options = {})
    super(options.merge(except: [:created_at, :updated_at]))  
  end

  private

  def prevent_protected_deletion
    if PROTECTED_TAGS .include?(name)
      errors.add(:base, "Cannot delete protected tag: '#{name}'")
      throw :abort
    end
  end
end
