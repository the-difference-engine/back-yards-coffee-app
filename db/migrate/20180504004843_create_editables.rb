class CreateEditables < ActiveRecord::Migration[5.0]
  def change
    create_table :editables do |t|
      t.text :about_me_sec_1
      t.string :about_me_pic_1
      t.text :about_me_sec_2
      t.string :about_me_pic_2
      t.text :about_me_sec_3
      t.string :about_me_pic_3

      t.timestamps
    end
  end
end
