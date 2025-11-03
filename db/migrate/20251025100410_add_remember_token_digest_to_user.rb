class AddRememberTokenDigestToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :remember_token_digest, :string
  end
end
