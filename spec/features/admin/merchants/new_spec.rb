require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  before :each do
    seed_db
  end
  
  describe 'new' do

    it 'shows a form to create a new merchant and sends back to merchant index' do
      visit "admin/merchants/new"

      fill_in('Name', with: 'Marco Polo')

      click_button('Submit')
      expect(current_path).to eq("/admin/merchants")

      expect(page). to have_link("Marco Polo")
      expect(page). to have_content("Marco Polo status: disabled")
    end
  end
end
