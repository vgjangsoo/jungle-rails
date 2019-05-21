require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do

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

  scenario "They see individual product detail" do
    # ACT
    visit root_path
    first('article.product h4').click
    sleep 3

    # DEBUG / VERIFY
    save_screenshot

    expect(page).to have_css 'article.product-detail'
  end

  
end
