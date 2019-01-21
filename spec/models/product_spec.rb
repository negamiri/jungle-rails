require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    @category = Category.new(
      id: 1,
      name: 'Decor'
    )
    @product = Product.new(
      name: 'Something',
      price_cents: 100,
      quantity: 1,
      category: @category
    )
  end

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(@product).to be_valid
    end

    it "is not valid when no name given" do
      @product.name = nil
      expect(@product).to_not be_valid
    end

    it "is not valid when no price given" do
      @product.price_cents = nil
      expect(@product).to_not be_valid
    end

    it "is not valid when no quantity given" do
      @product.quantity = nil
      expect(@product).to_not be_valid
    end

    it "is not valid when no category given" do
      @product.category = nil
      expect(@product).to_not be_valid
    end

    it "is saving correct error when invalid fields" do
      @product.name = nil
      @product.price_cents = nil
      @product.quantity = nil
      @product.category = nil
      @product.valid?
      expect(@product.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank", "Name can't be blank", "Quantity can't be blank", "Category can't be blank"])
    end


  end

end
