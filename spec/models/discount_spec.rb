require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant}
  end

  describe 'validations' do
    it { should validate_presence_of :percent }
    it { should validate_presence_of :threshold }
    it { should validate_numericality_of(:percent).is_greater_than(0).only_integer }
    it { should validate_numericality_of(:percent).is_less_than(100).only_integer }
    it { should validate_numericality_of(:threshold).is_greater_than(0).only_integer }
  end
end
