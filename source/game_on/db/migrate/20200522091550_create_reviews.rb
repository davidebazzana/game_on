class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text 'comments'
      t.references 'user', foreign_key: true
      t.references 'game', foreign_key: true

    end
  end
end
