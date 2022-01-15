class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.references :merchant, foreign_key: true
      t.integer :percent
      t.integer :threshold

      t.timestamps
    end
  end
end
