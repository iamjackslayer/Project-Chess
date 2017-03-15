require_relative "./board.rb"
require_relative "./player.rb"
require "yaml"

class Game
	def initialize
		@player1 = Player.new "white"
		@player2 = Player.new "black"
		make_table_of_coordinates_conversion
	end
	def run
		puts "Welcome to Chessssssss... CHAMPIONSHIP!!!"
		puts "Please input the position of the piece you want to move and the position you wish to move to. e.g 'a2 a3'."
		while true
				@player1.board.show
			while true
				@current_player = :player1
				print "player1's turn: "
				@player1_input = gets.chomp.downcase
				if (@player1_input =~ /^[a-h][1-7]\s[a-h][1-7]$/)
					@player1_input = @player1_input.split(" ")
					@player1_input = [array_index_of(@player1_input[0][0],@player1_input[0][1]),array_index_of(@player1_input[1][0],@player1_input[1][1])]#@player1_input is in the format of [[x1,y1],[x2,y2]] where elements are indices of board
					
				elsif @player1_input =~ /save/
					save(@current_player)
					exit
				elsif @player1_input =~ /load/
					load
					case @current_player #the @current_player here is the one loaded form the file
					when :player1 #the @player1 here is the one loaded from the file
						@player1.board.show
						next
					when :player2 #the @player2 here is the one loaded from the file
						break
					end
				else
					puts "Please input according to the format (letter)(number) (letter)(number)."
					next 
				end

				if @player1.move(@player1_input[0][0],@player1_input[0][1],@player1_input[1][0],@player1_input[1][1])
					break
				else
					puts "Please input coordinates again, player1."
				end
			end

				@player2.board.arr = reverse_board(@player1.board.arr)
				@player2.board.show
			while true
				@current_player = :player2
				print "player2's turn: "
				@player2_input = gets.chomp.downcase
				if (@player2_input =~ /[a-h][1-7]\s[a-h][1-7]/)
					@player2_input = @player2_input.split(" ")
					@player2_input = [array_index_of(@player2_input[0][0],@player2_input[0][1]),array_index_of(@player2_input[1][0],@player2_input[1][1])]#@player2_input is in the format of [[x1,y1],[x2,y2]] where elements are indices of board
				elsif @player2_input =~ /save/
					save(@current_player)
					exit
				elsif @player2_input =~ /load/
					load
					case @current_player #the @current_player here is the one loaded from the file
					when :player1 #the @player1 here is the one loaded from the file
						break
					when :player2 #the @player2 here is the one loaded from the file
						@player2.board.show
						next
					end
				else
					puts "Please input according to the format (letter)(number) (letter)(number)."
					next 	
				end
				if @player2.move(@player2_input[0][0],@player2_input[0][1],@player2_input[1][0],@player2_input[1][1])
					@player1.board.arr = reverse_board(@player2.board.arr)
					break
				else
					puts "Please input coordinates again, player2."
				end
			end

		end


	end

	def array_index_of row,column 
		#return array in format [x,y]
		[@input_to_coord_table[row],@input_to_coord_table[column]]
	end

	def make_table_of_coordinates_conversion
		@input_to_coord_table = {}
		("a".."h").to_a.each_with_index do |col,index|
			@input_to_coord_table[col] = index 
		end
		(1..8).to_a.each_with_index do |ro,index|
			@input_to_coord_table["#{ro}"] = 7 - index
		end
	end
	def coordinates_on_opp_board x,y
		[7-x,7-y]
	end
	def reverse_board opp_board
		board = opp_board.dup
		board.reverse!
		board.map {|row|row.reverse!}
		return board
	end

	def save current_player
		file_player1 = File.new("player1.txt","w+")
		file_player2 = File.new("player2.txt","w+")
		file_current_player = File.new("current_player.txt","w+")

		file_player1.write(YAML.dump(@player1))
		file_player2.write(YAML.dump(@player2))
		file_current_player.write(YAML.dump(current_player))

		file_player1.close
		file_player2.close
		file_current_player.close
	end

	def load 
		file_player1 = File.open("player1.txt","r")
		file_player2 = File.open("player2.txt","r")
		file_current_player = File.open("current_player.txt","r")

		@player1 = YAML.load(file_player1.read)
		@player2 = YAML.load(file_player2.read)
		@current_player = YAML.load(file_current_player.read)
		file_player1.close
		file_player2.close
		file_current_player.close
	end
end

Game.new.run