class CreateTaskTags < ActiveRecord::Migration[8.1]
  def change
    create_table :task_tags do |t|
      t.timestamps
    end
  end
end
