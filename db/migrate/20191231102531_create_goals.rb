class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.references :user, foreign_key: true

      t.string   :name
      t.text     :query
      t.string   :mapping
      t.string   :trigger_calculation
      t.string   :trigger_type
      t.string   :trigger_value
      t.bigint   :troll_twitter_id
      t.datetime :last_failed_at
      t.datetime :last_checked_at

      t.timestamps
    end
  end
end
