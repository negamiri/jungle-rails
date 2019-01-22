require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "able to add item to cart" do
    visit root_path
    
    first('article.product').click_button('Add')

    save_screenshot
    expect(find('nav.navbar')).to have_content("My Cart (1)")
  end

end
