class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string     :title, null: false
      t.integer    :price, null: false
      t.text       :introduction

      t.timestamps
    end
    add_foreign_key :products, :users
    add_foreign_key :products, :categories
  end
end
