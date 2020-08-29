class CreateInvitefriends < ActiveRecord::Migration[5.2]
  def change
    create_table :invitefriends do |t|

      t.timestamps
    end
  end
end
