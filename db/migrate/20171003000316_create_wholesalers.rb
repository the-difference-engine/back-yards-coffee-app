class CreateWholesalers < ActiveRecord::Migration[5.0]
  def change
    create_table :wholesalers do |t|
      t.string :business_name
      t.string :contact_name
      t.string :title
      t.string :work_phone
      t.string :alternate_phone

      t.timestamps
    end
  end
end
