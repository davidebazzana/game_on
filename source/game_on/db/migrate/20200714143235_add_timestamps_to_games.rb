class AddTimestampsToGames < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :games, default: Time.zone.now
    change_column_default :games, :created_at, nil
    change_column_default :games, :updated_at, nil
  end
end
