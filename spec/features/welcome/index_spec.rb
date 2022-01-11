require 'rails_helper'

RSpec.describe 'welcome page', type: :feature do
  context 'as a visitor' do
    it 'shows the name of the project' do
      visit root_path

      expect(page).to have_content("Little Esty Shop!")
    end
  end
end
