require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save a vaild product' do
      @category = Category.create(name:"Category")
      product = Product.new(
        name: "Anything",
        category_id: @category.id,
        price: 34.00,
        quantity: 15
      )
      expect(product).to (be_valid)
    end

    it 'is not valid without a name' do
      @category = Category.create(name:"Category")
      product = Product.new(
        name: nil,
        category_id: @category.id
      )
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      @category = Category.create(name:"Category")
      product = Product.new(
        name: "Anything",
        price: nil,
        category_id: @category.id
      )
      expect(product).to_not be_valid
    end

    it 'is not valid without a quantity' do
      @category = Category.create(name:"Category")
      product = Product.new(
        name: "Anything",
        price: 100,
        quantity: nil,
        category_id: @category.id
      )
      expect(product).to_not be_valid
    end

    it 'is not valid without a category' do
      product = Product.new(
        name: "Anything",
        price: 100,
        quantity: 30,
        category_id: nil
      )
      expect(product).to_not be_valid
    end
  end
end

