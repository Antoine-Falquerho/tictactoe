class Board

		WINLINES = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
		CONFIGS = {1 => "human vs OS", 2 => "OS vs OS"} #will add an other mode: 2 players


		attr_accessor :board, :current_player, :config, :players

		#initialize the board and define the current player if not present
		#I added board to the arguments so I can make the rspec tests easier and faster
	  def initialize board=nil, config=nil, players=nil
	    @board = board || Array.new(9, ".")	    
	    @config = config || @config
	    @players = players || @players
	    @current_player = @players.first
	    puts "Let's the game begin! #{@players.map{|player| player.name }.join(" vs ")}"
	  end

	  #will return the next player
	  def next_player	  
	  	@current_player == players[0] ? players[1] : players[0]
	  end

	  #check if we have a winner
	  def has_winner use_board=nil
	  	c_board = use_board || @board.dup
	  	tag = nil
	  	count = 0
	  	#Each winning lines
	  	WINLINES.each do |winning_positions|  	
	  		#all the positions of the winnings lines
	  		winning_positions.each do |position|
	  			if c_board[position] != "."
	  				if tag == c_board[position] or tag == nil
			  			tag = c_board[position]
			  			count += 1 #we want to know tag the user has on this line
			  		end
		  		end
		  		if count == 3 #if we have a count of 3, we have a winner
		  			return tag
		  		end 
	  		end
	  		#reset the value to nil and 0 to test the next line
	  		tag = nil
	  		count = 0
	  	end
	  	return nil #we don't have any winner for this round
	  end

	  #will return the user who use the tag (X/O)
	  def user_from_tag tag
	  	players.each do |player|
				return player if player.tag == tag
			end
	  end

	  #Render the current Board
	  def render_board with_number=nil
	  	board = @board.dup
	  	#Replace the available spot by the number associated to make it easier to play. Only if with_number is true (mean the user tape help in the console)
	  	board.each_with_index.map{|val, index| board[index] = val != "." ? val : index.to_s} if with_number
	  	puts "---------------"
	  	board.each_slice(3).each{|line| p line}
	  	puts "---------------"
	  	return board
	  end

	  #Will return all the possible movements 
	  #Array of positions
	  def possible_move
	  	@board.each_with_index.map{|el, index| index if @board[index] == "."}.compact
	  end

	  #will return the best move for the current user.
	  def best_move
	  	#First we check if we can win
	  	#If not
	  	#then we will check if we have to block the the other player
	  	tag = @current_player.tag#will be the tag of the user we test
	  	2.times do 
		  	possible_move.each do |move|#we test all the possible movements
		  		c_board = @board.dup	  		
		  		c_board[move] = tag
		  		if has_winner c_board#do we have a winner with this move? if yes, we use this move
		  			return move
		  		end
		  	end
		  	tag = next_player.tag #for the second iteration, we will try to block the other player
		  end
	  	return 4 if @board[4] == "." #would block the player if it chooses the corners
	  	possible_move.sample
	  end

	  #the computer has to win, so he play the best move only
	  def computer_play
	  	play best_move
	  end

	  #will add the tag of the current player to the board
	  def play position
	  	#if the current position is free
	  	if @board[position] == "."	  		
		  	@board[position] = @current_player.tag
		  	@current_player = next_player		  
		  else#the position is not free so we let the player play again
		  	p "you can't do this move, play again #{@player}:"
		  	get_user_input
		  	return nil
		  end
	  end

	  #will get the user input and play. It will also set the next player
	  def get_user_input
	  	puts "What is your move #{@current_player.name}?"
		  move = gets.gsub("\n","")
		  
		  if move.to_s.downcase == "help" #If we tape help, we will render the board with the number associated with each position. (to make it easier)
		  	render_board(true)
		  	get_user_input
		  	return nil
		  end

		  if move.to_i.nil? #the move is not correct, we let the player try again
		  	puts "this is not a correct move! Try again #{@current_player.name}!"
		  	get_user_input
		  	return nil
		  end
		  return play(move.to_i) #we will add the user choice to the dashboard
	  end

	  #the game is done
	  #we want to show the scores
	  def show_results	  	
	  	if has_winner #we have a winner
	  		user_from_tag(has_winner).score += 10	  		
	  		puts "We got a winner! Good Job #{user_from_tag(has_winner).name}!"	
	  		puts "Score:"
		  	players.each do |player|
		  		puts "#{player.name}: #{player.score} points"
		  	end
	  	else #there is no winner for this game
	  		puts "No winner for this game"
	  	end

	  	puts "RESULTS"

	  	render_board #At the end of the game we render the final board
	  end

	  #Will render which kind of game we have. "Player vs OS" or "OS vs OS"
	  def config_mode
	  	CONFIGS[@config]
	  end

	  #main method to start the game
	  def start
	  	while not has_winner and not possible_move.empty? do #has long we don't have a winner but still have possible movements
	  		render_board
	  		#if the user want to see OS vs OS
	  		if @config == 2 #if the game is "os vs os", no need to wait for the user input. We could have use current_player.is_human? here ...
	  			play best_move
	  		else	  						  	
		  		get_user_input #get the user movement
		  		computer_play if not has_winner and not possible_move.empty?
		  	end		  	
	  	end
	  	show_results

	  	p "You want to play again? Y/N"
	  	replay = gets.gsub("\n","")
	  	if replay.downcase == "y" #make sure we downcase the input of the user so Y and y will work
	  		initialize
	  		start
	  	else	  		
		  	return "Bye!"
	  	end
	  end
	  	
	end