require 'rails_helper'

RSpec.describe 'Admin Invoices Show' do
  before :each do
    seed_db
  end

  describe 'view' do

    it 'I see information related to that invoice' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@invoice_1.customer.first_name)
      expect(page).to have_content(@invoice_1.customer.last_name)
    end

    it 'I see the total revenue that will be generated from this invoice' do
      invoice_1 = @customer_1.invoices.create!
      ii = invoice_1.invoice_items.create!(item_id: @item_5.id, quantity: 20, unit_price: 100, status: 0)
      ii_1 = invoice_1.invoice_items.create!(item_id: @item_7.id, quantity: 7, unit_price: 200, status: 0)
      expected_cents = (ii.quantity * ii.unit_price + ii_1.quantity * ii_1.unit_price)

      visit "/admin/invoices/#{invoice_1.id}"

      expect(page).to have_content("Total revenue generated: #{h.number_to_currency(expected_cents, precision: 0)}")
    end

    it 'I can update the invoice status' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content("pending")
      select "in progress", from: "invoice_status"
      click_on "Update Invoice Status"

      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
      expect(page).to have_content("#{@invoice_1.status}")
    end

    it 'displays all of the items and their attributes' do
      visit "/admin/invoices/#{@invoice_1.id}"

      within "#invoice_show-#{@invoice_1.id}" do
        expect(page).to have_content("#{@invoice_1.invoice_items.first.item.name}")
        expect(page).to have_content("#{@invoice_1.invoice_items.first.quantity}")
        expect(page).to have_content("#{@invoice_1.invoice_items.first.unit_price}")
        expect(page).to have_content("#{@invoice_1.invoice_items.first.status}")
      end
    end

    it 'I see the total revenue that will be generated from this invoice with discounts' do
      d1 = Discount.create!(merchant_id: @merchant_1.id, percent: 25, threshold: 10)
      d2 = Discount.create!(merchant_id: @merchant_1.id, percent: 50, threshold: 20)

      invoice_1 = @customer_1.invoices.create!
      ii = invoice_1.invoice_items.create!(item_id: @item_5.id, quantity: 20, unit_price: 100, status: 0)
      ii_1 = invoice_1.invoice_items.create!(item_id: @item_7.id, quantity: 7, unit_price: 200, status: 0)
      expected_cents = (ii.quantity * ii.unit_price * d2.percent/100 + ii_1.quantity * ii_1.unit_price)

      visit "/admin/invoices/#{invoice_1.id}"

      expect(page).to have_content("Total discounted revenue generated: #{h.number_to_currency(expected_cents, precision: 0)}")
    end
  end
end
