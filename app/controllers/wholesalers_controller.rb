class WholesalersController < ApplicationController
  def new
    @wholesaler = Wholesaler.new 
    render "new.html.erb"
  end 

  def create 
    render "create.html.erb"
  end
end
