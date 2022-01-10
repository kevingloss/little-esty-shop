require 'rails_helper'

RSpec.describe 'Admin Invoices Show' do
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
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Total revenue generated:#{@invoice_1.total_revenue}")
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
  end
end
