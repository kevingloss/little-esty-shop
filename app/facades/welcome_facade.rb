require './app/models/poro/esty_service'
require './app/models/poro/repo'
require './app/models/poro/team'

class WelcomeFacade
  def repo_info
    Repo.new(service.repo)
  end

  # def team_info
  # wip = Team.new(service.contributor)
  # # require "pry"; binding.pry
  # end

  def service
    EstyService.new
  end
end
