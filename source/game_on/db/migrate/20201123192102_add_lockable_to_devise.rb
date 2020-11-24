class AddLockableToDevise < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime
  end
end
