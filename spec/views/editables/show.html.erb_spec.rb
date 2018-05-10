require 'rails_helper'

RSpec.describe "editables/show", type: :view do
  before(:each) do
    @editable = assign(:editable, Editable.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
