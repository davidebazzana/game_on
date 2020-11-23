class CreateContactdevs < ActiveRecord::Migration[5.2]
  def change
    create_table :contactdevs do |t|
      
      t.timestamps
    end
  end
end
