class Discount < ApplicationRecord
  belongs_to :merchant
  validates :percent, numericality: { greater_than: 0, less_than: 100 }, presence: true
  validates :threshold, numericality: { greater_than: 0 }, presence: true
end
