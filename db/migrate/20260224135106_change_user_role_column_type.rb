class ChangeUserRoleColumnType < ActiveRecord::Migration[8.0]
  def up
    create_enum :role_enum, ['basic','moderator','admin']

    remove_column :users, :role
    add_column :users, :role, :enum, enum_type: :role_enum, default: 'basic'
  end

  def down
    remove_column :users, :role
    change_column :users, :role, :integer
  end
end
