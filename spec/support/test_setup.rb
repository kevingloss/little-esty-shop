module TestSetup
  def seed_db
    @merchant_1 = Merchant.create!(name: "Frank")

    # @merchant_2 = Merchant.create!(name: "Mike")
    # Items
    @item_1 = @merchant_1.items.create!(name: "Item_1", description: "Description_1", unit_price: 16)
    @item_2 = @merchant_1.items.create!(name: "Item_2", description: "Description_2", unit_price: 23)
    @item_3 = @merchant_1.items.create!(name: "Item_3", description: "Description_3", unit_price: 11)
    @item_4 = @merchant_1.items.create!(name: "Item_4", description: "Description_4", unit_price: 312)
    @item_5 = @merchant_1.items.create!(name: "Item_5", description: "Description_5", unit_price: 23)
    @item_6 = @merchant_1.items.create!(name: "Item_6", description: "Description_6", unit_price: 41)
    @item_7 = @merchant_1.items.create!(name: "Item_7", description: "Description_7", unit_price: 153)
    @item_8 = @merchant_1.items.create!(name: "Item_8", description: "Description_8", unit_price: 1)
    @item_9 = @merchant_1.items.create!(name: "Item_9", description: "Description_9", unit_price: 15)
    @item_10 = @merchant_1.items.create!(name: "Item_10", description: "Description_10", unit_price: 87)

    # @item_11 = @merchant_2.items.create!(name: "Item_11", description: "Description_11", unit_price: 1515)
    # @item_12 = @merchant_2.items.create!(name: "Item_12", description: "Description_12", unit_price: 8787)
    #customer
    @customer_1 = Customer.create!(first_name: "Customer", last_name: "1")
    @customer_2 = Customer.create!(first_name: "ACustomer", last_name: "2")
    @customer_3 = Customer.create!(first_name: "BCustomer", last_name: "3")
    @customer_4 = Customer.create!(first_name: "CCustomer", last_name: "4")
    @customer_5 = Customer.create!(first_name: "DCustomer", last_name: "5")
    @customer_6 = Customer.create!(first_name: "ECustomer", last_name: "6")

    # @customer_7 = Customer.create!(first_name: "FCustomer", last_name: "7")
    # @customer_8 = Customer.create!(first_name: "GCustomer", last_name: "8")
    #invoices
    @invoice_1 = @customer_1.invoices.create!
    @invoice_2 = @customer_2.invoices.create!
    @invoice_3 = @customer_2.invoices.create!
    @invoice_4 = @customer_3.invoices.create!
    @invoice_5 = @customer_3.invoices.create!
    @invoice_6 = @customer_3.invoices.create!
    @invoice_7 = @customer_4.invoices.create!
    @invoice_8 = @customer_4.invoices.create!
    @invoice_9 = @customer_4.invoices.create!
    @invoice_10 = @customer_4.invoices.create!
    @invoice_11 = @customer_5.invoices.create!
    @invoice_12 = @customer_5.invoices.create!
    @invoice_13 = @customer_5.invoices.create!
    @invoice_14 = @customer_5.invoices.create!
    @invoice_15 = @customer_6.invoices.create!
    @invoice_16 = @customer_6.invoices.create!
    @invoice_17 = @customer_6.invoices.create!
    @invoice_18 = @customer_6.invoices.create!
    @invoice_19 = @customer_6.invoices.create!
    @invoice_20 = @customer_6.invoices.create!

    # @invoice_20 = @customer_7.invoices.create!
    # @invoice_21 = @customer_7.invoices.create!
    # @invoice_22 = @customer_8.invoices.create!
    # @invoice_23 = @customer_8.invoices.create!
    #invoice items
    @invoice_1.invoice_items.create!(item_id: @item_1.id, quantity: 1, unit_price: @item_1.unit_price, status: 0)
    @invoice_2.invoice_items.create!(item_id: @item_2.id, quantity: 70, unit_price: @item_2.unit_price, status: 0)
    @invoice_3.invoice_items.create!(item_id: @item_3.id, quantity: 3, unit_price: @item_3.unit_price, status: 0)
    @invoice_4.invoice_items.create!(item_id: @item_4.id, quantity: 400, unit_price: @item_4.unit_price, status: 0)
    @invoice_5.invoice_items.create!(item_id: @item_5.id, quantity: 100, unit_price: @item_5.unit_price, status: 1)
    @invoice_6.invoice_items.create!(item_id: @item_6.id, quantity: 160, unit_price: @item_6.unit_price, status: 1)
    @invoice_7.invoice_items.create!(item_id: @item_7.id, quantity: 399, unit_price: @item_7.unit_price, status: 1)
    @invoice_8.invoice_items.create!(item_id: @item_8.id, quantity: 8, unit_price: @item_8.unit_price, status: 1)
    @invoice_9.invoice_items.create!(item_id: @item_9.id, quantity: 9, unit_price: @item_9.unit_price, status: 1)
    @invoice_10.invoice_items.create!(item_id: @item_10.id, quantity: 350, unit_price: @item_10.unit_price, status: 1)
    @invoice_11.invoice_items.create!(item_id: @item_1.id, quantity: 1, unit_price: @item_1.unit_price, status: 1)
    @invoice_12.invoice_items.create!(item_id: @item_2.id, quantity: 80, unit_price: @item_2.unit_price, status: 1)
    @invoice_13.invoice_items.create!(item_id: @item_3.id, quantity: 13, unit_price: @item_3.unit_price, status: 1)
    @invoice_14.invoice_items.create!(item_id: @item_4.id, quantity: 444, unit_price: @item_4.unit_price, status: 1)
    @invoice_15.invoice_items.create!(item_id: @item_5.id, quantity: 120, unit_price: @item_5.unit_price, status: 1)
    @invoice_16.invoice_items.create!(item_id: @item_6.id, quantity: 165, unit_price: @item_6.unit_price, status: 2)
    @invoice_17.invoice_items.create!(item_id: @item_7.id, quantity: 399, unit_price: @item_7.unit_price, status: 2)
    @invoice_18.invoice_items.create!(item_id: @item_8.id, quantity: 18, unit_price: @item_8.unit_price, status: 2)
    @invoice_19.invoice_items.create!(item_id: @item_8.id, quantity: 18, unit_price: @item_8.unit_price, status: 0)
    @invoice_20.invoice_items.create!(item_id: @item_7.id, quantity: 18, unit_price: @item_7.unit_price, status: 0)

    # @invoice_20.invoice_items.create!(item_id: @item_11.id, quantity: 13, unit_price: @item_11.unit_price, status: 2)
    # @invoice_21.invoice_items.create!(item_id: @item_12.id, quantity: 17, unit_price: @item_12.unit_price, status: 2)
    # @invoice_22.invoice_items.create!(item_id: @item_11.id, quantity: 18, unit_price: @item_11.unit_price, status: 2)
    # @invoice_23.invoice_items.create!(item_id: @item_12.id, quantity: 18, unit_price: @item_11.unit_price, status: 0)
    #transaction
    @invoice_1.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_2.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_3.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_4.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_5.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_6.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_7.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_8.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_9.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_10.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_11.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_12.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_13.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_14.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_15.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_16.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_17.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_18.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
    @invoice_19.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "failed")
    @invoice_20.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "failed")
  end
end
