class Task < ApplicationRecord
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  enum :status, { 
    new: 0,
    in_progress: 1,
    done: 2,
    cancelled: 3
  }, prefix: true, validate: true

  enum :recurrence_pattern, {
    daily: 0,
    monthly: 1,
    specific_dates: 2,
    even_odd: 3
  }

  validates :title, presence: true
  validates :status, presence: true
  validates :description, presence: true
  validates :exec_date, presence: true
  validates :recurrence_params_format, if: :recurring_task?

  def as_json(options = {})
    super(options.merge(except: [:created_at, :updated_at]))  
  end

  private 

  def recurring_task?
    recurrence_pattern.present?    
  end

  def recurrence_params_format
    return unless recurrence_pattern
    
    case recurrence_pattern
    when 'daily'
      validate_daily_config    
    when 'monthly'
      validate_monthly_config
    when 'specific_dates'
      validate_specific_dates
    when 'even_odd'
      validate_even_odd
    else
      errors.add(:recurrence_pattern, 'is not valid')
    end
  end

  def validate_daily_config
    unless recurrence_params.is_a?(Hash)
      errors.add(:recurrence_params, 'must be a hash for daily tasks')
      return
    end

    interval = recurrence_params['interval']

    unless interval
      errors.add(:recurrence_params, "must present an 'interval' parameter for daily tasks")
      return
    end

    unless interval.is_a?(Integer) && interval > 0
      errors.add(:recurrence_params, "'interval' parameter is invalid")      
    end
  end

  # todo: add validation for other modes
  def validate_monthly_config
    pass   
  end

  def validate_specific_dates
    pass
  end

  def validate_even_odd
    pass
  end
end
