require 'rails_helper'
## i had to remove the before each here because we needed the complete dataset to run the more
## complex tests. I commented out and didn't delete anything. all tests pass.
RSpec.describe "Merchant item index" do
  before :each do
    seed_db
  end

  it 'I see a list of the names of all of my items' do
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
  end

  it 'each items name is a link to the show page' do
    visit "/merchants/#{@merchant_1.id}/items"

    click_link "#{@item_1.name}"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
  end

  it 'displays two sections, one for Enabled Items and one for Disabled Items' do
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_content("Enabled Items")
    expect(page).to have_content("Disabled Items")
  end

  it 'has enabled items in the enabled section and disable items in disabled section' do
    visit "/merchants/#{@merchant_1.id}/items"

    within '#enableditems' do
      expect(page).to have_no_content
    end

    within '#disableditems' do
      expect(page).to have_link("Item_1")
      expect(page).to have_link("Item_2")
      expect(page).to have_link("Item_3")
    end
  end

  it 'has a link to create a new item' do
    visit "/merchants/#{@merchant_1.id}/items"

    expect(page).to have_link("Create a New Item")
    click_link "Create a New Item"
  end


  it 'has an enable button for each item that changes the status' do
    visit merchant_items_path(@merchant_1)

    within("#item-#{@item_1.id}") do
      click_button("Enable")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
    end
  end

  it 'has a disable button for each item that changes the status' do
    visit merchant_items_path(@merchant_1)

    within("#item-#{@item_1.id}") do
      click_button("Enable")

      expect(current_path).to eq(merchant_items_path(@merchant_1))

      click_button("Disable")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
    end
  end

  it 'show the top 5 most popular items and links to the merchant_items show page' do
    visit merchant_items_path(@merchant_1)
    within "#top_five_items" do
      @merchant_1.top_five_items.each do |item|
        expect(page).to have_content(item.name)
        expect(page).to have_content(h.number_to_currency(item.revenue/100, precision: 0))
      end
      click_link(@item_4.name)
    end

    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_4))
  end

  it 'shows the date of the most sales for the top 5 items' do
    visit merchant_items_path(@merchant_1)
    within "#top_five_items" do
      @merchant_1.top_five_items.each do |item|
        expect(page).to have_content(item.top_item_best_day.strftime("%A, %B %d, %Y"))
      end
    end
  end
end
