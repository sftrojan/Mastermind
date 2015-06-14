class Game
	def initialize
		@counter = 0
		@guesses = []
		@key_pegs = []
		@code = color_pegs
		welcome
		setting_game_loop
	end 

	def welcome
		puts "Welcome to Mastermind!\n"
		puts "The you may select to create a secret code, or the computer can\n"
		puts "randomly select a four color code (may repeat in color) from \n"
		puts "(R)ed, (B)lue, (G)reen, (O)range, (Y)ellow and (P)urple\n"
		puts "You have 12 chances to guess the right code, and the key pegs\n"
		puts "Will give you a hint at how many colors and positions you have correct\n"
		puts "Black Pegs mean the peg is the right color and the right position\n"
		puts "White Pegs mean the peg is the right color, wrong position.\n\n"
	end 

	def user
		puts "Do you want to create (type 'create') the secret code, or break (type 'break') the computer-generated secret code?"
		user_choice = gets.chomp
	end 

	def user_code_entry
		puts "Create a 4 color code (which may repeat colors) from\n"
		puts "(R)ed, (B)lue, (G)reen, (O)range, (Y)ellow and (P)urple"
		@code = gets.chomp.upcase.split('')
	end

	def setting_game_loop
		user_choice = user
		if user_choice == "break"
			game_loop
		else
			computer_guess_code
		end 
	end 

	def color_pegs
		colors = ["R", "B", "G", "O", "Y", "P"]
		[colors[rand(5)], colors[rand(5)], colors[rand(5)], colors[rand(5)]]
	end 

	def valid_user_entry(user_choice)
		user_choice == ("create" || "break")
	end 

	def valid_move?(guess)
		guess.all? { |x| ["R", "B", "G", "O", "Y", "P"].include?(x) } && guess.length == 4
	end 

	def valid_user_code?
		@code.all? { |x| ["R", "B", "G", "O", "Y", "P"].include?(x) } && @code.length == 4
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

	def computer_guess_code
		user_code_entry
		until valid_user_code?
   			puts "This is not a valid color choice. Try again!"
   			user_code_entry
  		end

		loop do 
			@guesses << color_pegs
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
			puts "\n\n The computer has #{(12-@counter)} turns left"
		end
	end 
end


