require 'rails_helper'

describe Api::V1::ProductsController do
  describe 'POST #create' do
    it 'has to be created' do
      post :create, name: FFaker::Product.product_name,
                    price: rand() * 100,
                    description: FFaker::Lorem.paragraph

      expect(response.status).to eq(201)
    end

    it 'should has 422 status code' do
      post :create, name: FFaker::Product.product_name,
                    description: FFaker::Lorem.paragraph
      expect(response.status).to eq(422)
    end

    it "should has error 'can't be blank' for name" do
      post :create, price: rand() * 100
      expect(JSON.parse(response.body)).to eq(
        "errors" => {"name"=>["can't be blank"]})
    end

    it "should has error 'is not a number' and 'can't be blank' for price" do
      post :create, name: FFaker::Product.product_name,
                    description: FFaker::Lorem.paragraph
      expect(JSON.parse(response.body)).to eq(
        "errors" => {"price"=>["is not a number", "can't be blank"]})
    end

    it "should has error 'is not a number' for price" do
      post :create, name: FFaker::Product.product_name,
                    price: FFaker::Lorem.paragraph
      expect(JSON.parse(response.body)).to eq(
        "errors" => {"price"=>["is not a number"]})
    end

    it 'should has 3 error messages' do
      post :create, name: nil,
                    price: nil
      expect(JSON.parse(response.body)).to eq(
        "errors" => {"name"=>["can't be blank"], "price"=>["is not a number", "can't be blank"]})
    end

    it "should has 'is too long' message for name" do
      post :create, name: (0...51).map { ('a'..'z').to_a[rand(26)] }.join,
                    price: rand() * 100
      expect(JSON.parse(response.body)).to eq(
        "errors" => {"name"=>["is too long (maximum is 50 characters)"]})
    end

    it "should has 'is too long' message for description" do
      post :create, description: (0...401).map { ('a'..'z').to_a[rand(26)] }.join,
                    price: rand() * 100,
                    name: FFaker::Product.product_name
      expect(JSON.parse(response.body)).to eq(
        "errors" => {"description"=>["is too long (maximum is 400 characters)"]})
    end
  end
end
