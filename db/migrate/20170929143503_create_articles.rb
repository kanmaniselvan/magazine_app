class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :user_id, null: false

      t.timestamps

      t.index :title
      t.index :content, length: 767
      t.index [:user_id, :title], unique: true
    end
  end
end
