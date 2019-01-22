require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'
    @product = @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
  end

  scenario "they see all the info about the product" do
    visit root_path
    first('article.product').click_link('Details')
    expect(page).to have_content(@product.description)
  end

end
