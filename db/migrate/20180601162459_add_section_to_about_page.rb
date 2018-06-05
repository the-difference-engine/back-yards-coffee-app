class AddSectionToAboutPage < ActiveRecord::Migration[5.0]
  def change
    add_column :editables, :about_me_sec_4, :text
    add_column :editables, :about_me_pic_4, :string
  end
end
