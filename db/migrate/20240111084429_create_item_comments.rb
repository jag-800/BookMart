class CreateItemComments < ActiveRecord::Migration[6.1]
  def change
    create_table :item_comments do |t|
      t.text :comment
      t.integer :customer_id
      t.integer :item_id

      t.timestamps
    end
  end
end
