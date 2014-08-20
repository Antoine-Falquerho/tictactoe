require "spec_helper"

describe Board do
	before do
		#let's set the players we will use for all our tests
		@player1 = Player.new("Antoine", "X")
		@player2 = Player.new("Computer 0", "O")
		@players = [@player1, @player2]
	end

	describe "initialize" do
		it "should set the board and the current_player should be 'X'" do
			b = Board.new nil, 1, @players
			b.board.should == Array.new(9, ".")
			b.current_player.should == @player1		
		end		
	end

	describe "next_player" do
		it "should return the next player" do
			b = Board.new nil, 1, @players
			b.current_player = @player1
			b.next_player.should == @player2
			b.current_player = @player2
			b.next_player.should == @player1
		end
	end

	describe "has_winner" do
		it "should return the winner if we have one" do
			b = Board.new [
				".", "O", ".",
				"X", ".", "X",
				".", ".", "O"], 1, @players
				b.has_winner.should be_nil

			#this time we should have a winner
			b = Board.new [
				".", "O", ".",
				"X", "X", "X",
				".", ".", "O"], 1, @players
				b.has_winner.should == "X"
				b.user_from_tag("X").should == @player1
		end
	end

	describe "user_from_tag" do
		it "should return the user from the tag X or O" do
			b = Board.new Array.new(9, ".")	, 1, @players
			b.user_from_tag("X").should == @player1
			b.user_from_tag("O").should == @player2
		end
	end

	describe "possible_move" do
		it "should render the number of possible move" do
			b = Board.new nil, 1, @players
			b.possible_move.count.should == 9
			b.board[2] = "O"
			b.possible_move.count.should == 8
			b.board.should_not include(2)

			b.board = Array.new(9, "X")
			b.possible_move.should be_empty
		end
	end

	describe "best_move" do	
		it "should return the best move" do
			b = Board.new [
				".", "O", ".",
				"X", ".", "X",
				".", ".", "O"], 1, @players
				b.current_player = @player2
				b.best_move.should == 4

				#other test
				#the current player can win, so he should win
			b = Board.new [
				"O", ".", "X",
				".", ".", "X",
				"O", ".", "."], 1, @players
				b.current_player = @player1
				b.best_move.should == 8

				#other test
				#the curent user can't win, but he has to block the other user
				b = Board.new [
				"O", ".", "X",
				".", "X", ".",
				"O", ".", "."], 1, @players
				b.current_player = @player1
				b.best_move.should == 3

				#if the position of the middle is free, we should always take it
				b = Board.new [
				"O", ".", ".",
				".", ".", ".",
				".", ".", "X"], 1, @players
				b.current_player = @player1
				b.best_move.should == 4
		end
	end	

	describe "play" do
		it "should add the choice of the user to the board" do
			b = Board.new [
				".", "O", ".",
				"X", ".", "X",
				".", ".", "O"], 1, @players
			b.current_player = @player2
			b.current_player.tag.should == "O"
			b.play 4
			b.board.should == [
				".", "O", ".",
				"X", "O", "X",
				".", ".", "O"]
		end
	end

	describe "render_board" do
		it "should render the board correctly with or without number" do
			b = Board.new [
				".", "O", ".",
				"X", ".", "X",
				".", ".", "O"], 1, @players

			b.render_board.should == [".", "O", ".", "X", ".", "X", ".", ".", "O"]
			b.render_board(true).should == ["0", "O", "2", "X", "4", "X", "6", "7", "O"]
		end
	end

	describe "user_from_tag" do
		it "should return the user who have the tag" do			
			b = Board.new nil, 1, @players
			b.user_from_tag("X").should == @player1
		end
	end

end