class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :image
      t.text :body
      t.references :postable, polymorphic: true
      t.integer :creator_id
      t.timestamps
    end
  end
end
