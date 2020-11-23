class AddVersionToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :version, :string, null: true
  end
end
