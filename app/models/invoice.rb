class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants
  validates :status, presence: true
  enum status: { cancelled: 0, "in progress" => 1, completed: 2, pending: 3 }

  def merchant_items(merchant)
    invoice_items.joins(:merchant)
                 .where("merchant_id = ?", merchant)
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

# this one works, but feels like too much ruby
  def total_discounted_revenue
    invoice_items.sum do |ii|
      ii.discounted_ii_revenue
    end
  end

  def total_merchant_revenue(merchant)
    merchant_items(merchant).sum("invoice_items.unit_price * invoice_items.quantity")
  end

  # def merchant_discounted_revenue(merchant)
    # require 'pry'; binding.pry
    # getting closer for this approach
    # savings = invoice_items.joins(:discounts).where("invoice_items.quantity >= threshold").select("invoice_items.*, max(discounts.percent/100 * invoice_items.quantity * invoice_items.unit_price) as savings").group("invoice_items.id").sum(&:savings)
  # end

  # def merchant_discounted_revenue(merchant)
  #   total_merchant_revenue(merchant) - savings
  # end

# this one works
  def merchant_discounted_revenue(merchant)
    merchant_items(merchant).sum {|invoice_item| invoice_item.discounted_ii_revenue }
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not(invoice_items: {status: "shipped"})
    .order(created_at: :asc)
    .distinct
  end
end
