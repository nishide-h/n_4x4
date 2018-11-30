class AddSelectflgToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :select1, :boolean, default: false, null: false
    add_column :tasks, :select2, :boolean, default: false, null: false
    add_column :tasks, :select3, :boolean, default: false, null: false
  end
end
