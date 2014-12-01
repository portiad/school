class RockPaperScissors

  # Exceptions this class can raise:
  class NoSuchStrategyError < StandardError ; end

  def self.winner(player1, player2)
    wins = {"R" => "S", "P" => "R", "S" => "P"}
		p1 = player1[1]
		p2 = player2[1]
		
		validate(player1[1])
		validate(player2[1])

		if wins[p1] == p2
			return player1
		elsif p1 == p2
			return player1
		else
			return player2
		end 
  end
	
	def self.validate(choice)
		raise NoSuchStrategyError.new('Strategy must be one of R,P,S') unless ['R','P','S'].include?(choice)
	end

  def self.tournament_winner(tournament)
    p1, p2 = tournament
    return self.winner(p1, p2) if p1[0].class == String
    p1 = self.tournament_winner(p1)
    p2 = self.tournament_winner(p2)
    self.tournament_winner([p1, p2])
  end
end
