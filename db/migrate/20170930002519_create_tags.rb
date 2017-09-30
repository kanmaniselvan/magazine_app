class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :parent_id, default: Tag::TAG_PARENT_ID, null: false
      t.integer :article_id, null: false

      t.index :parent_id
      t.index :article_id
      t.index [:name, :parent_id, :article_id], unique: true
    end
  end
end
