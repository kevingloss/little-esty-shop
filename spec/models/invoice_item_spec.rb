require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_many(:transactions).through(:invoice) }
    it { should have_one(:merchant).through(:item) }
    it { should have_many(:discounts).through(:merchant) }
  end

  before :each do
    seed_db
  end

  it 'can calculate an invoice item discounted revenue' do
    @d1 = Discount.create!(merchant_id: @merchant_1.id, percent: 25, threshold: 10)
    @d2 = Discount.create!(merchant_id: @merchant_1.id, percent: 50, threshold: 20)
    @d3 = Discount.create!(merchant_id: @merchant_1.id, percent: 75, threshold: 100)
    @d4 = Discount.create!(merchant_id: @merchant_1.id, percent: 10, threshold: 5)

    ii_1 = @invoice_4.invoice_items.create!(item_id: @item_5.id, quantity: 20, unit_price: 100, status: 0)
    ii_2 = @invoice_4.invoice_items.create!(item_id: @item_2.id, quantity: 3, unit_price: 400, status: 0)

    expect(ii_1.discounted_ii_revenue).to eq(1000)
    expect(ii_2.discounted_ii_revenue).to eq(1200)
  end

  it '#discount_applied' do
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

    expect(@invoice_4.invoice_items.first.discount_applied).to eq(@d3)
    expect(@invoice_4.invoice_items.last.discount_applied).to eq(nil)
  end

  it '#discounted_ii_revenue' do
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

    expect(@invoice_4.invoice_items.first.discounted_ii_revenue).to eq(31200)
    expect(@invoice_4.invoice_items.last.discounted_ii_revenue).to eq(1200)
  end
end
