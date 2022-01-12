class Team
  attr_reader :logins

  def initialize(data)
    @logins = team_member(data)
  end

  def team_member(data)
    team = ['kevingloss', 'Dittrir', 'kanderson852', 'dkassin', 'Eagerlearn']
    team_logins = []
    data.each do |contributor|
      if team.include?(contributor[:login])
        inter = []
        inter << contributor[:login]
        inter << contributor[:contributions]
        team_logins << inter
      end
    end
    team_logins
  end
end
