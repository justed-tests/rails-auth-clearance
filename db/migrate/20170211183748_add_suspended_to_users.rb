# mega feature
class AddSuspendedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :suspended, :boolean, default: false, index: true
  end
end
