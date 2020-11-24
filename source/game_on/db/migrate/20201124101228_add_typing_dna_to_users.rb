class AddTypingDnaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :typing_tries, :integer, default: 0
    add_column :users, :enrolled, :boolean, default: false
    add_column :users, :logs, :integer, default: 0
  end
end
