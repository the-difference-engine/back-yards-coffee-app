require 'rails_helper'


  RSpec.describe Employee, type: :model do

    describe '#email' do
    
      it 'should return the email in the model' do
        employee = Employee.create(email: "employee@gmail.com")
        expect(employee.email).to eq("employee@gmail.com")
      end
     
      it "is invalid without an email address" do
        employee = build(:employee, email: nil)
        employee.valid?
        expect(employee.errors[:email]).to include("can't be blank")
      end

    end

  end


