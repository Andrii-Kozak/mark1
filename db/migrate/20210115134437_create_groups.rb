class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :group_name
      t.string :description
      t.integer :group_type, default: 0

      t.timestamps
    end
  end
end
