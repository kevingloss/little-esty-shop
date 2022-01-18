class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice
  has_one :merchant, through: :item
  has_many :discounts, through: :merchant
  validates :quantity, :unit_price, :status, presence: true
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  def discount_applied
    discounts.order(percent: :desc)
             .where("threshold <= ?", self.quantity)
             .first
  end

  def discounted_ii_revenue
    if discount_applied == nil
      quantity * unit_price
    else
      quantity * unit_price * (1 - (discount_applied.percent/100.to_f))
    end
  end
end
