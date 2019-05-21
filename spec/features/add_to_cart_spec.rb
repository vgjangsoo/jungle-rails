require 'rails_helper'

RSpec.feature "Visitor clicks 'Add to Cart' button", type: :feature, js: true do

  # SETUP
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

  scenario "their cart increases by one" do
    # ACT
    visit root_path
    first('article.product button').click
    sleep 3

    # DEBUG / VERIFY
    save_screenshot

    expect(page).to have_content('My Cart (1)')
  end

  
end
