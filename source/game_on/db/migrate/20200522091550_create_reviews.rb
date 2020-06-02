class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
    t.text 'comments'
    t.references 'user'
    t.references 'game'

    end
  end
end