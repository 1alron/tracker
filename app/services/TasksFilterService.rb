class TasksFilterService
  def initialize(params)
    @params = params
    @tasks = Task.all
  end

  def call
    filter_by_date
    filter_by_status
    @tasks
  end

  private

  def filter_by_date
    start_date = parse_date(@params[:start_date])
    end_date = parse_date(@params[:end_date])

    return @tasks = Task.none if (@params[:start_date].present? && start_date.nil?) ||
      (@params[:end_date].present? && end_date.nil?)

    @tasks = @tasks.where("exec_date >= ?", start_date) if start_date.present?
    @tasks = @tasks.where("exec_date <= ?", end_date) if end_date.present?
  end

  def filter_by_status
    return if @params[:status].blank?
    @tasks = @tasks.where(status: @params[:status])
  end

  def parse_date(date_string)
    return nil if date_string.blank?
    DateTime.parse(date_string)
  rescue ArgumentError, TypeError
    nil
  end
end
