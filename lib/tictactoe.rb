require 'tictactoe/version'
require 'tictactoe/board'
require 'tictactoe/player'

module Tictactoe

		TAG = {0 => "X", 1 => "O"}

		def self.start
			players = []
			puts "Let's play Tic tac toe"
			puts "Do you want to:"
			puts "1 - play versus the OS"
			puts "2 - See the OS fight himself?"
			puts "INFO: At every moment tape help to get the best move!"
			puts "Select:"
			choice = nil
			while not [1,2].include? choice.to_i do				
				choice = gets.to_i
				puts "Not a correct choice! Try again:" if not [1,2].include? choice.to_i
			end
			
			if choice.to_i == 1
				puts "What is your name?"
				name = gets.gsub("\n","")
				players << Player.new(name, TAG[players.count], true)
			end

			(2 - players.count).times do |i|
				players << Player.new("Computer #{i}", TAG[players.count])
			end

			ttt = Board.new nil, choice, players
			ttt.start
		end

end