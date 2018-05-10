require 'rails_helper'

RSpec.describe "editables/new", type: :view do
  before(:each) do
    assign(:editable, Editable.new())
  end

  it "renders new editable form" do
    render

    assert_select "form[action=?][method=?]", editables_path, "post" do
    end
  end
end
