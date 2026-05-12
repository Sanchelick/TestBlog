class RemovePasswordResetFieldsFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :password_reset_token
    remove_column :users, :password_reset_token_sent_at
  end
end
