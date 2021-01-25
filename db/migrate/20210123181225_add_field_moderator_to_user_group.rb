class AddFieldModeratorToUserGroup < ActiveRecord::Migration[6.1]
  def change
    add_column :user_groups, :moderator, :boolean, default: false
  end
end
