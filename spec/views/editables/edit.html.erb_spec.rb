require 'rails_helper'

RSpec.describe "editables/edit", type: :view do
  before(:each) do
    @editable = assign(:editable, Editable.create!())
  end

  it "renders the edit editable form" do
    render

    assert_select "form[action=?][method=?]", editable_path(@editable), "post" do
    end
  end
end
