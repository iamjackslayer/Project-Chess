class Board
	attr_accessor :arr
	def initialize
		@arr = [
					[" ♜ "," ♞ "," ♝ "," ♛ "," ♚ "," ♝ "," ♞ "," ♜ "],
					[" ♟ "," ♟ "," ♟ "," ♟ "," ♟ "," ♟ "," ♟ "," ♟ "],
					[" . "," . "," . "," . "," . "," . "," . "," . "],
					[" . "," . "," . "," . "," . "," . "," . "," . "],
					[" . "," . "," . "," . "," . "," . "," . "," . "],
					[" . "," . "," . "," . "," . "," . "," . "," . "],
					[" ♙ "," ♙ "," ♙ "," ♙ "," ♙ "," ♙ "," ♙ "," ♙ "],
					[" ♖ "," ♘ "," ♗ "," ♕ "," ♔ "," ♗ "," ♘ "," ♖ "],
				]
	end

	def show
		puts "===============================================\n"
		print "\t"
		("a".."h").each {|i| print "  #{i}  "}
		print "\n\n"
		puts

		@arr.each_with_index do |column,index|
			print "\s\s\s#{8-index}\s\s\s\s"
			column.each do |piece|
				print " #{piece} "
			end
			puts "\n\n"
		end

		print "\n\t"
		("a".."h").each {|i| print "  #{i}  "}
		puts
		puts "==============================================="
	end

end
# Board.new.show