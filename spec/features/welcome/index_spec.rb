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

      expected = WelcomeFacade.new.team_info.logins

      expect(page).to have_content("User Login: #{expected[0][0]} Commit Count: #{expected[0][1]}")
      expect(page).to have_content("User Login: #{expected[1][0]} Commit Count: #{expected[1][1]}")
      expect(page).to have_content("User Login: #{expected[2][0]} Commit Count: #{expected[2][1]}")
      expect(page).to have_content("User Login: #{expected[3][0]} Commit Count: #{expected[3][1]}")
      expect(page).to have_content("User Login: #{expected[4][0]} Commit Count: #{expected[4][1]}")
    end
  end
end
