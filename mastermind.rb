class Game
	def initialize
		@counter = 0
		@guesses = []
		@key_pegs = []
		@code = color_pegs
	end 

	def color_pegs
		colors = ["R", "B", "G", "O", "Y", "P"]
		[colors[rand(5)], colors[rand(5)], colors[rand(5)], colors[rand(5)]]
	end 

	def valid_move?(guess)
		guess.all? { |x| ["R", "B", "G", "O", "Y", "P"].include?(x) } && guess.length == 4
	end 

	def win?
		@counter <=12 && (@guesses.last == @code)
	end 

	def out_of_guesses
		@counter == 12 && (@guesses.values_at(0..3) != @code.values_at(0..3))
	end

	def compare
		pegs = []
		no_duplicates = []
		4.times do |x|
			if @code[x] == (@guesses.last[x])	
				pegs << "Black Peg"
				no_duplicates << @code[x]
			end 
		end 
		4.times do |x|
			if (@code.count(@guesses.last[x]) > no_duplicates.count(@guesses.last[x])) 
				pegs << "White Peg"
			end 
		end 

		@key_pegs << pegs
		puts "Key Pegs: #{@key_pegs.last.inspect}"
	end 
	
	def print_guesses
		@guesses.each{|x| puts x.join('')}
	end 

	def game_loop
		
		puts "Welcome to Mastermind!\n"
		puts "The computer has randomly selected a four color code (may repeat in color)\n"
		puts "from (R)ed, (B)lue, (G)reen, (O)range, (Y)ellow and (P)urple\n"
		puts "You have 12 chances to guess the right code, and the key pegs\n"
		puts "Will give you a hint at how many colors and positions you have correct\n"
		puts "Black Pegs mean the peg is the right color and the right position\n"
		puts "White Pegs mean the peg is the right color, wrong position."
		#please remove this later
		puts @code
		loop do 
			puts "What is your guess?"
			guess = gets.chomp.upcase.split('')

			if valid_move?(guess)
        		@guesses << guess        		
     		else
       			puts "This is not a valid color choice. Try again!"
       			redo
      		end
    	
			compare
   			print_guesses

        	
	  		if win?
				puts "Congratulations! You broke the code!"
				exit
			elsif out_of_guesses
				puts "You ran out of chances to break the code! Try again later!"
				exit
			end

		@counter +=1
		puts "\n\n You have #{(12-@counter)} turns left"
    	end 		
	end	
end


