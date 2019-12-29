class AddingUserFields < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter_access_token, :string
    add_column :users, :twitter_access_token_secret, :string
    add_column :users, :twitter_uid, :string
  end
end
