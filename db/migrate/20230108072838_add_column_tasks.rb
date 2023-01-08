class AddColumnTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :priority_level, :integer, null: false, default: 0
  end
end
