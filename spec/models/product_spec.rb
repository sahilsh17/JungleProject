require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should validate if product is successfully saved in database" do
      @category = Category.find_or_create_by(name: "Apparel")
      @product = @category.products.create(name:"Jacket",price:100, quantity:20)
      
      expect(@product.id).to be_present 
    end
    it "should display error if product name is not provided" do
      @category = Category.find_or_create_by(name: "Electronics")
      @product = @category.products.create(price:500, quantity:1)
      
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it "should display error if product price is not set" do
      @category = Category.find_or_create_by(name: "Electronics")
      @product = @category.products.create(name: "PS4", quantity:1)
      
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it "should display error if product quantity is not set" do
      @category = Category.find_or_create_by(name: "Furniture")
      @product = @category.products.create(name: "Table", price:430)
      
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "should validate if the product has category assigned to it" do
      @category = Category.find_or_create_by(name: "Electronics")
      @product = @category.products.create(name: "PS4", quantity:1)
      
      expect(@product.category.name).to eq("Electronics")
    end
  end
end
