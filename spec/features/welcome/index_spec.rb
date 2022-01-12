require 'rails_helper'

RSpec.describe 'welcome page', type: :feature do
  context 'as a visitor' do
    it 'shows the name of the project' do
      visit root_path

      expect(page).to have_content("Little Esty Shop!")
    end

    xit 'shows the name of the repo' do
      visit root_path

      expect(page).to have_content(WelcomeFacade.new.repo_info.name)
    end

    it 'has the login names of our team' do
      visit root_path

      team = ['kevingloss', 'Dittrir', 'kanderson852', 'dkassin', 'Eagerlearn']

      expect(page).to have_content(team)
    end
  end
end
