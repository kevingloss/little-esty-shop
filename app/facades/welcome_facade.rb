require './app/models/poro/esty_service'
require './app/models/poro/repo'

class WelcomeFacade
  def repo_info
    Repo.new(service.repo)
  end

  def service
    EstyService.new
  end
end
