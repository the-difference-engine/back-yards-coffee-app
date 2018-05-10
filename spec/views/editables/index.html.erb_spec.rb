require 'rails_helper'

RSpec.describe "editables/index", type: :view do
  before(:each) do
    assign(:editables, [
      Editable.create!(),
      Editable.create!()
    ])
  end

  it "renders a list of editables" do
    render
  end
end
