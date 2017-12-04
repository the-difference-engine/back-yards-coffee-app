require 'rails_helper'

RSpec.describe Api::EmployeesController, type: :controller do
  describe 'GET api/employees#index' do
    render_views
    before :each do
      create(:employee)
      get :index
    end
    it 'assigns the employees to @employees' do
      expect(assigns(:employees)).to eq Employee.all
    end
    it 'renders the index.json.jbuilder template' do
      expect(response).to render_template 'index.json.jbuilder'
    end
    it 'responds with type JSON' do
      expect(response.content_type).to eq 'application/json'
    end
    it 'renders the correct JSON' do
      json = JSON.parse(response.body)
      expect(json.first.keys).to eq %w[id email]
      expect(json.first['email']).to match(/employeedoe\d@example\.com/)
    end
  end
end
