begin
	
	puts "Bonjour, quel est votre prenom ?"
	prenom = gets.chomp
	
	nombre = rand(1..100)
	
	100.times do |tour|
	puts "\n------------------ Tour numéro #{tour} ------------------"
	
	puts "Allez #{prenom} entrez votre nombre entre 1 et 100!!!"
	user_entry = gets.to_i

		if user_entry < nombre && user_entry >= 1
			puts "------------------Vous etes trop bas..."
			
		elsif user_entry > nombre && user_entry <= 100
			puts "------------------Vous etes trop haut"

		elsif user_entry == nombre
			puts "------------------#{prenom} a gagne en #{tour} tours"
		else
			puts "Etes vous sur d'avoir mis un nombre entre 1 et 100 !!!!"
		end
		
	
break if user_entry == nombre
end
	puts "------------------Voulez vous rejouer ? (o/n) "
	rejouer = gets.chomp.downcase
	
end while ["oui", "o"].include?(rejouer)

puts "Bye"

	
	
	






