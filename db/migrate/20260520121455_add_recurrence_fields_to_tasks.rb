class AddRecurrenceFieldsToTasks < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :recurrence_pattern, :integer
    add_column :tasks, :recurrence_params, :jsonb
    add_column :tasks, :recurrence_end_date, :date
    add_column :tasks, :parent_task_id, :integer
  end
end
