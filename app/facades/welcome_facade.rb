require './app/models/poro/esty_service'
require './app/models/poro/repo'
require './app/models/poro/team'

class WelcomeFacade
  def repo_info
    Repo.new(service.repo)
  end

  def team_info
    Team.new(service.contributor)
  end

  def service
    EstyService.new
  end
end
