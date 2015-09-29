class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.belongs_to :post
      t.belongs_to :commenter
      t.timestamps
    end
  end
end
