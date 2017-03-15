require_relative "./board.rb"
class Player
	attr_accessor :board, :own_pieces, :enemy_pieces
	def initialize color
		@color = color.downcase
		@board = Board.new
		if @color =~ /white/
			@own_pieces = [" ♙ "," ♖ "," ♘ "," ♗ "," ♔ "," ♕ "]
			@enemy_pieces = [" ♟ "," ♜ "," ♞ "," ♝ "," ♚ "," ♛ "]
		elsif @color =~ /black/
			@own_pieces = [" ♟ "," ♜ "," ♞ "," ♝ "," ♚ "," ♛ "]
			@enemy_pieces = [" ♙ "," ♖ "," ♘ "," ♗ "," ♔ "," ♕ "]
		end

	end

	def move x1,y1,x2,y2
		#instance variables are created for these two as they are needed by #available_coordinates_of() and #check_victory().
		@x2 = x2 
		@y2 = y2 
		if @own_pieces.any?{|i|i == @board.arr[y1][x1]} && (@enemy_pieces.any?{|i| i == @board.arr[y2][x2]} || @board.arr[y2][x2] == " . ")
			print "your cor: #{available_coordinates_of(x1,y1)}"
			if available_coordinates_of(x1,y1).any?{|i| i == [x2,y2]}
				check_victory(x1,y1)
				@board.arr[y1][x1],@board.arr[y2][x2] = " . ",@board.arr[y1][x1]
				pawn_promotion(y2)
				check(x2,y2)
				true
			else
				puts "Invalid move(unavailable)"
				false
			end
		else 
			puts "Invalid move"
			false
		end
	end

	def available_coordinates_of x,y
		piece = @board.arr[y][x]
		avail_arr = [] #2D array [[available x-coordinate,available y-coordinate],[...],[...],[...]]
		if piece == " ♜ " || piece == " ♖ "
			#rightward
			i = x + 1
			until i > 7
				break if @own_pieces.any?{|item| item == @board.arr[y][i]}
				avail_arr << [i,y]
				break if @enemy_pieces.any?{|item| item == @board.arr[y][i]}
				i += 1
			end
			#leftward
			i = x - 1
			until i < 0 
				break if @own_pieces.any?{|item| item == @board.arr[y][i]}
				avail_arr << [i,y]
				break if @enemy_pieces.any?{|item| item == @board.arr[y][i]}
				i -= 1
			end
			#upward
			i = y - 1
			until i < 0 
				break if @own_pieces.any?{|item| item == @board.arr[i][x]}
				avail_arr << [x,i]
				break if @enemy_pieces.any?{|item| item == @board.arr[i][x]}
				i -= 1
			end
			#downward
			i = y + 1
			until i > 7 
				break if @own_pieces.any?{|item| item == @board.arr[i][x]}
				avail_arr << [x,i]
				break if @enemy_pieces.any?{|item| item == @board.arr[i][x]}
				i += 1
			end

		elsif piece == " ♞ " || piece == " ♘ "
			avail_arr = [[x-1,y-2],[x-1,y+2],[x+1,y-2],[x+1,y+2],[x-2,y-1],[x+2,y-1],[x-2,y+1],[x+2,y+1]]
			
		elsif piece == " ♝ " || piece == " ♗ "
			
			#northwest direction
			i = x - 1
			j = y - 1
			until i == -1 || j == -1
				break if @own_pieces.any?{|item| item == @board.arr[j][i]}
				avail_arr << [i,j]
				break if @enemy_pieces.any?{|item| item == @board.arr[j][i]}
				i -= 1
				j -= 1
			end
			#northeast direction
			i = x + 1
			j = y - 1
			until i == 8 || j == -1
				break if @own_pieces.any?{|item| item == @board.arr[j][i]}
				avail_arr << [i,j]
				break if @enemy_pieces.any?{|item| item == @board.arr[j][i]}
				i += 1
				j -=1
			end
			# southwest direction
			i = x - 1
			j = y + 1
			until i == -1 || j == 8
				break if @own_pieces.any?{|item| item == @board.arr[j][i]}
				avail_arr << [i,j]
				break if @enemy_pieces.any?{|item| item == @board.arr[j][i]}
				i -= 1 
				j += 1
			end
			# southeast direction
			i = x + 1
			j = y + 1
			until i == 8 || j == 8
				break if @own_pieces.any?{|item| item == @board.arr[j][i]}
				avail_arr << [i,j]
				break if @enemy_pieces.any?{|item| item == @board.arr[j][i]}
				i += 1
				j += 1
			end
		elsif piece == " ♚ " || piece == " ♔ "
			#rightward
			i = x + 1
			until i > 7
				break if @own_pieces.any?{|item| item == @board.arr[y][i]}
				avail_arr << [i,y]
				break if @enemy_pieces.any?{|item| item == @board.arr[y][i]}
				i += 1
			end
			#leftward
			i = x - 1
			until i < 0 
				break if @own_pieces.any?{|item| item == @board.arr[y][i]}
				avail_arr << [i,y]
				break if @enemy_pieces.any?{|item| item == @board.arr[y][i]}
				i -= 1
			end
			#upward
			i = y - 1
			until i < 0 
				break if @own_pieces.any?{|item| item == @board.arr[i][x]}
				avail_arr << [x,i]
				break if @enemy_pieces.any?{|item| item == @board.arr[i][x]}
				i -= 1
			end
			#downward
			i = y + 1
			until i > 7 
				break if @own_pieces.any?{|item| item == @board.arr[i][x]}
				avail_arr << [x,i]
				break if @enemy_pieces.any?{|item| item == @board.arr[i][x]}
				i += 1
			end

			#northwest direction
			i = x - 1
			j = y - 1
			until i == -1 || j == -1
				break if @own_pieces.any?{|item| item == @board.arr[j][i]}
				avail_arr << [i,j]
				break if @enemy_pieces.any?{|item| item == @board.arr[j][i]}
				i -= 1
				j -= 1
			end
			#northeast direction
			i = x + 1
			j = y - 1
			until i == 8 || j == -1
				break if @own_pieces.any?{|item| item == @board.arr[j][i]}
				avail_arr << [i,j]
				break if @enemy_pieces.any?{|item| item == @board.arr[j][i]}
				i += 1
				j -=1
			end
			# southwest direction
			i = x - 1
			j = y + 1
			until i == -1 || j == 8
				break if @own_pieces.any?{|item| item == @board.arr[j][i]}
				avail_arr << [i,j]
				break if @enemy_pieces.any?{|item| item == @board.arr[j][i]}
				i -= 1 
				j += 1
			end
			# southeast direction
			i = x + 1
			j = y + 1
			until i == 8 || j == 8
				break if @own_pieces.any?{|item| item == @board.arr[j][i]}
				avail_arr << [i,j]
				break if @enemy_pieces.any?{|item| item == @board.arr[j][i]}
				i += 1
				j += 1
			end
			
		elsif piece == " ♛ " || piece == " ♕ "
			avail_arr = [[x-1,y-1],[x,y-1],[x+1,y-1],[x+1,y],[x+1,y+1],[x,y+1],[x-1,y+1],[x-1,y]]
		elsif piece == " ♟ " || piece == " ♙ "
			if y == 6  #if pawn has not moved forward
				if @x2 == x && (@y2 == y - 1 || @y2 == y - 2) #if pawn is to move vertically forward
					i = y - 1
					until i == y - 3
						break if @own_pieces.any?{|item| item == @board.arr[i][x]} || @enemy_pieces.any?{|item| item == @board.arr[i][x]}
						avail_arr << [x,i]
						i -= 1
					end
				elsif @y2 == y - 1 && (@x2 == x - 1 || @x2 == x + 1) #if pawn is to move diagonally forward
					if @enemy_pieces.any?{|item| item == @board.arr[@y2][@x2]}
						avail_arr << [@x2,@y2]
					end
				end
			else #if pawn has already moved forward
				if @y2 == y - 1 && @x2 == x  #if pawn is to move vertically forward
					
					unless @own_pieces.any?{|item| item == @board.arr[@y2][x]} || @enemy_pieces.any?{|item| item == @board.arr[@y2][x]}
						avail_arr << [x,@y2]
					end
				elsif @y2 == y - 1 && (@x2 == x - 1 || @x2 == x + 1) #if pawn is to move diagonally forward
						
					if @enemy_pieces.any?{|item| item == @board.arr[@y2][@x2]}
						avail_arr << [@x2,@y2]
					end
					
				end
			end
			
					
		end

		# clean up avail_arr by removing out-of-bound coordinates
		avail_arr.each_with_index do |pair,index|
			pair.each do |axis|
				if axis < 0 || axis > 7
					avail_arr.delete_at(index)
				end
			end
		end
		#clean up avail_arr by removing repeating coordinates
		avail_arr.uniq!
		#make the current position unavailable
		avail_arr.delete([x,y])
		return avail_arr
	end

	def check_victory x1,y1
		if @board.arr[@y2][@x2] == " ♕ " || @board.arr[@y2][@x2] == " ♛ "
			@board.arr[y1][x1],@board.arr[@y2][@x2] = " . ",@board.arr[y1][x1]
			@board.show
			puts "Game Over"
			exit
		end

	end

	def check x,y
		if available_coordinates_of(x,y).any?{|coordinates| @board.arr[coordinates[1],coordinates[0]] == " ♕ " || @board.arr[coordinates[1],coordinates[0]] == " ♛ " } 
			puts "CHECK"
		end
	end

	def pawn_promotion current_y_coordinate
		if current_y_coordinate == 0 && @board.arr[@y2][@x2] == " ♙ "
			@board.show
			puts "Your pawn is promoted. Please choose a piece:"
			print "\t"
			@own_pieces[1..-2].each_with_index do |i,index|
				print " #{index+1}. #{i} "
			end
			puts
			while true
				input = gets.chomp.to_i
				if (1..4).to_a.any?{|i| i == input}
					break
				else
					puts "CHOOSE FROM 1 TO 4 ONLY!"
				end
			end

			@board.arr[@y2][@x2] = @own_pieces[input]
		end

	end

end