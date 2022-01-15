require 'rails_helper'

RSpec.describe "Discount Show Page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, item_status: 1)
    @item2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
    @item7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
    @item8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

    @item5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
    @item6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

    @customer1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

    @invoice1 = Invoice.create!(customer_id: @customer1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @invoice2 = Invoice.create!(customer_id: @customer1.id, status: 2, created_at: "2012-03-28 14:54:09")
    @invoice3 = Invoice.create!(customer_id: @customer2.id, status: 2)
    @invoice4 = Invoice.create!(customer_id: @customer3.id, status: 2)
    @invoice5 = Invoice.create!(customer_id: @customer4.id, status: 2)
    @invoice6 = Invoice.create!(customer_id: @customer5.id, status: 2)
    @invoice7 = Invoice.create!(customer_id: @customer6.id, status: 2)

    @invoice8 = Invoice.create!(customer_id: @customer6.id, status: 2)

    @ii1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 9, unit_price: 10, status: 0)
    @ii2 = InvoiceItem.create!(invoice_id: @invoice2.id, item_id: @item1.id, quantity: 5, unit_price: 10, status: 0)
    @ii3 = InvoiceItem.create!(invoice_id: @invoice3.id, item_id: @item2.id, quantity: 5, unit_price: 8, status: 2)
    @ii4 = InvoiceItem.create!(invoice_id: @invoice4.id, item_id: @item3.id, quantity: 8, unit_price: 5, status: 1)
    @ii6 = InvoiceItem.create!(invoice_id: @invoice5.id, item_id: @item4.id, quantity: 9, unit_price: 1, status: 1)
    @ii7 = InvoiceItem.create!(invoice_id: @invoice6.id, item_id: @item7.id, quantity: 10, unit_price: 3, status: 1)
    @ii8 = InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item8.id, quantity: 3, unit_price: 5, status: 1)
    @ii9 = InvoiceItem.create!(invoice_id: @invoice7.id, item_id: @item4.id, quantity: 2, unit_price: 1, status: 1)
    @ii10 = InvoiceItem.create!(invoice_id: @invoice8.id, item_id: @item5.id, quantity: 15, unit_price: 1, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice2.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice3.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice4.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice5.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice6.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice7.id)
    @transaction8 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice8.id)

    @d1 = Discount.create!(merchant_id: @merchant1.id, percent: 25, threshold: 5)
    @d2 = Discount.create!(merchant_id: @merchant1.id, percent: 50, threshold: 8)
    @d3 = Discount.create!(merchant_id: @merchant1.id, percent: 75, threshold: 10)
    @d4 = Discount.create!(merchant_id: @merchant1.id, percent: 10, threshold: 2)
    @d5 = Discount.create!(merchant_id: @merchant2.id, percent: 30, threshold: 3)
  end

  it 'links to discount show page from the discounts index' do
    visit merchant_discounts_path(@merchant1)

    within("#discount-#{@d1.id}") do
      click_link "See More Details"
    end

    expect(current_path).to eq(merchant_discount_path(@merchant1, @d1))
  end

  it 'has the threshold and percentage discount' do
    visit merchant_discounts_path(@merchant1)

    expect(page).to have_content(@d1.threshold)
    expect(page).to have_content(@d1.percent)
    expect(page).to_not have_content(@d2.threshold)
    expect(page).to_not have_content(@d2.percent)
  end
end
