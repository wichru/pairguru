class AddUserIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :user, foreign_key: true, unique: true
  end
end
