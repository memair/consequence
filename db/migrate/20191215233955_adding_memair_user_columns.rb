class AddingMemairUserColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :memair_access_token, :string
  end
end
