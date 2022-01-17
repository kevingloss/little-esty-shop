require 'rails_helper'

RSpec.describe Invoice do
  before :each do
    seed_db
  end

  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:discounts).through(:merchants) }
  end

  it '#total_revenue' do
    expect(@invoice_1.total_revenue).to eq(16)
    expect(@invoice_4.total_revenue).to eq(124800)
  end

  it '#total_merchant_revenue' do
    @invoice_4.invoice_items.create!(item_id: @item_5.id, quantity: 20, unit_price: 100, status: 0)
    @merchant_2 = Merchant.create!(name: "Mike")
    @item_11 = @merchant_2.items.create!(name: "Item_11", description: "Description_11", unit_price: 150)
    @invoice_4.invoice_items.create!(item_id: @item_11.id, quantity: 5, unit_price: @item_11.unit_price, status: 1)

    expect(@invoice_4.total_merchant_revenue(@merchant_1)).to eq(126800)
  end

  it 'filters to only a specific merchants items' do
    @merchant_2 = Merchant.create!(name: "Mike")

    @item_11 = @merchant_2.items.create!(name: "Item_11", description: "Description_11", unit_price: 150)
    invoice_1 = @customer_1.invoices.create!
    ii_1 = invoice_1.invoice_items.create!(item_id: @item_11.id, quantity: 5, unit_price: @item_11.unit_price, status: 1)
    ii_2 = invoice_1.invoice_items.create!(item_id: @item_5.id, quantity: 20, unit_price: 100, status: 0)
    ii_3 = invoice_1.invoice_items.create!(item_id: @item_7.id, quantity: 7, unit_price: 200, status: 0)
    ii_4 = invoice_1.invoice_items.create!(item_id: @item_10.id, quantity: 10, unit_price: 300, status: 0)
    ii_5 = invoice_1.invoice_items.create!(item_id: @item_2.id, quantity: 3, unit_price: 400, status: 0)

    expect(invoice_1.merchant_items(@merchant_1)).to eq([ii_2, ii_3, ii_4, ii_5])
  end

  it '#total_discounted_revenue' do
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

    expect(@invoice_4.total_discounted_revenue).to eq(37435)
  end

  describe 'models' do
    it '#incomplete_invoices' do
      expected_result = [@invoice_1, @invoice_2, @invoice_3,
                         @invoice_4, @invoice_5, @invoice_6,
                         @invoice_7, @invoice_8, @invoice_9,
                         @invoice_10, @invoice_11, @invoice_12,
                         @invoice_13, @invoice_14, @invoice_15,
                         @invoice_19, @invoice_20]

      #Expected result ordered oldest to newest

      expect(Invoice.incomplete_invoices).to eq(expected_result)
    end
  end

  it '#merchant discounted revenue' do
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

    expect(@invoice_4.merchant_discounted_revenue(@merchant_1)).to eq(36910)
  end
end
