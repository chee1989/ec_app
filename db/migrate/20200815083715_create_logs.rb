class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :type
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_foreign_key :logs, :users
  end
end
