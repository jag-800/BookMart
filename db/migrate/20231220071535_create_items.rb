class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :customer_id, null: false
      t.references :buyer, foreign_key: { to_table: :customers }, null: true
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
