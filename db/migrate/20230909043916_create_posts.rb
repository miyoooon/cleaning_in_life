class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.timestamps
      t.string :title, null: false
      t.text :text, null: false
      t.integer :user_id
      t.integer :tag_id
    end
  end
end
