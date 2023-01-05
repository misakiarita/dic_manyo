class AddExpiredAtToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :due, :datetime, default: -> { 'NOW()' }, null: false
  end
end
