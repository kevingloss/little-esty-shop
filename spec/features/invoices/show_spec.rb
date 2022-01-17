require 'rails_helper'

RSpec.describe "Merchant invoice show" do
  before :each do
    seed_db
    @merchant_2 = Merchant.create!(name: "Mike")
    @d1 = Discount.create!(merchant_id: @merchant_1.id, percent: 25, threshold: 5)
    @d2 = Discount.create!(merchant_id: @merchant_1.id, percent: 50, threshold: 8)
    @d3 = Discount.create!(merchant_id: @merchant_1.id, percent: 75, threshold: 10)
    @d4 = Discount.create!(merchant_id: @merchant_1.id, percent: 10, threshold: 2)
    @d5 = Discount.create!(merchant_id: @merchant_2.id, percent: 30, threshold: 3)
  end

  it 'shows all the information relation to the invoice' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y") )
    expect(page).to have_content(@invoice_1.customer.first_name)
    expect(page).to have_content(@invoice_1.customer.last_name)
  end

  it 'shows all items and information' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    @invoice_1.invoice_items.each do |invoice_item|
      expect(page).to have_content(invoice_item.item.name)
      expect(page).to have_content(invoice_item.quantity)
      expect(page).to have_content("Price: #{h.number_to_currency(invoice_item.unit_price/100, precision: 0)}")
      expect(page).to have_content(invoice_item.status)
    end
  end

  it 'does not show other merchants items info' do
    other_merchant = Merchant.create!(name: "Mike")
    other_merchant_item = other_merchant.items.create!(name: "Item_11", description: "Description_11", unit_price: 150)
    @invoice_1.invoice_items.create!(item_id: other_merchant_item.id, quantity: 5, unit_price: other_merchant_item.unit_price, status: 1)

    visit merchant_invoice_path(@merchant_1, @invoice_1)

    expect(page).to_not have_content("#{other_merchant_item.name}")
  end

  it 'has a select field to update the invoice_item status' do
    visit merchant_invoice_path(@merchant_1, @invoice_1)

    @invoice_1.invoice_items.each do |invoice_item|
      expect(page).to have_content("pending")
      select "packaged", from: "invoice_item_status"
      click_on "Update Item Status"

      expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1))
      expect(page).to have_content("#{invoice_item.status}")
    end
  end

  it 'I see the total revenue that will be generated from all of my items on the invoice' do
    visit merchant_invoice_path(@merchant_1, @invoice_4)
    expect(page).to have_content("Total Revenue")
    expect(page).to have_content(h.number_to_currency(@invoice_4.total_merchant_revenue(@merchant_1)/100, precision: 0))
  end

  it 'shows the total discounted revenue' do
    @merchant_2 = Merchant.create!(name: "Mike")

    @d1 = Discount.create!(merchant_id: @merchant_1.id, percent: 25, threshold: 10)
    @d2 = Discount.create!(merchant_id: @merchant_1.id, percent: 50, threshold: 20)
    @d3 = Discount.create!(merchant_id: @merchant_1.id, percent: 75, threshold: 100)
    @d4 = Discount.create!(merchant_id: @merchant_1.id, percent: 10, threshold: 5)
    @d5 = Discount.create!(merchant_id: @merchant_2.id, percent: 30, threshold: 3)

    @item_11 = @merchant_2.items.create!(name: "Item_11", description: "Description_11", unit_price: 150)

    @invoice_4.invoice_items.create!(item_id: @item_11.id, quantity: 5, unit_price: @item_11.unit_price, status: 1)
    @invoice_4.invoice_items.create!(item_id: @item_5.id, quantity: 20, unit_price: 100, status: 0)
    @invoice_4.invoice_items.create!(item_id: @item_7.id, quantity: 7, unit_price: 200, status: 0)
    @invoice_4.invoice_items.create!(item_id: @item_10.id, quantity: 10, unit_price: 300, status: 0)
    @invoice_4.invoice_items.create!(item_id: @item_2.id, quantity: 3, unit_price: 400, status: 0)

    visit merchant_invoice_path(@merchant_1, @invoice_4)

    expect(page).to have_content(h.number_to_currency(@invoice_4.merchant_discounted_revenue(@merchant_1)/100, precision: 0))
  end
end
