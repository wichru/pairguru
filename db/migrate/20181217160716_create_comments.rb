class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :movie, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
