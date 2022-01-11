class WelcomeController < ApplicationController
  def index
    @facade = WelcomeFacade.new
  end
end
