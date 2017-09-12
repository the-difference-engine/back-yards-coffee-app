class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 5, scale: 2
      t.integer :category_id

      t.timestamps
    end
  end
end
