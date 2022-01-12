# class Team
#   attr_reader :logins
#
#   def initialize(data)
#     @logins = team_member(data)
#   end
#
#   def team_member(data)
#     team = ['kevingloss', 'Dittrir', 'kanderson852', 'dkassin', 'Eagerlearn']
#     team_logins = []
#     data.each do |contributor|
#       inter = []
#       if team.include?(contributor[:login])
#       inter << contributor[:login]
#       inter << contributor[:contributions]
#       team_logins << inter
#       end
#     end
#     team_logins
#   end
# end
