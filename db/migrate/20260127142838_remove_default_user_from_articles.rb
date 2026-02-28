class RemoveDefaultUserFromArticles < ActiveRecord::Migration[8.0]
  def up
    change_column_default :articles, :user_id, from: User.first.id, to: nil
  end

  def down
    change_column_default :articles, :user_id, from: nil, to: User.first.id
  end
end
