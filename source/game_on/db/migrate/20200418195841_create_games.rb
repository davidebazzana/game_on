class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string 'title'
      t.text 'info'
      t.timestamp
    end
  end
end
