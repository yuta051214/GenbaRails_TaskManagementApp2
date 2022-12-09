class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def up
    # null制約があるのためテーブルを空にし、DB上でUserとTaskを紐付ける(tasks：複数形)
    execute "DELETE FROM tasks"
    add_reference :tasks, :user, null: false, index: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end
end
