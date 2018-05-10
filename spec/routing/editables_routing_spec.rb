require "rails_helper"

RSpec.describe EditablesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/editables").to route_to("editables#index")
    end

    it "routes to #new" do
      expect(:get => "/editables/new").to route_to("editables#new")
    end

    it "routes to #show" do
      expect(:get => "/editables/1").to route_to("editables#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/editables/1/edit").to route_to("editables#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/editables").to route_to("editables#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/editables/1").to route_to("editables#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/editables/1").to route_to("editables#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/editables/1").to route_to("editables#destroy", :id => "1")
    end

  end
end
