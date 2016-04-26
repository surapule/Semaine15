class Personne
  attr_accessor :nom, :points_de_vie, :en_vie

  def initialize(nom)
    @nom = nom
    @points_de_vie = 100
    @en_vie = true
  end

  def info
	if @points_de_vie <= 0 
		@en_vie = false
		puts "#{@nom} est Vaincu"
	else 
	 puts "#{@nom} a #{@points_de_vie}/100 Points de Vie"
		
	end
  end

  def attaque(personne)
	self.degats
		personne.subit_attaque(@degats)
		puts "#{self.nom} attaque #{personne.nom}"
		puts "#{personne.nom} a subit #{@degats} degats"
		puts "#{personne.info}"
    # A faire:
    # - Fait subir des dégats à la personne passée en paramètre
    # - Affiche ce qu'il s'est passé
  end

  def subit_attaque(degats_recus)
	@points_de_vie -= degats_recus
	
    # A faire:
    # - Réduit les points de vie en fonction des dégats reçus
    # - Affiche ce qu'il s'est passé
    # - Détermine si la personne est toujours en_vie ou non
  end
end

class Joueur < Personne
  attr_accessor :degats_bonus

  def initialize(nom)
    # Par défaut le joueur n'a pas de dégats bonus
    @degats_bonus = 0
	@degats = 0
    # Appelle le "initialize" de la classe mère (Personne)
    super(nom)
  end

  def degats
	@degats = rand(10..50) + degats_bonus
	
    # A faire:
    # - Calculer les dégats
    # - Affiche ce qu'il s'est passé
  end

  def soin
	
	@points_de_vie += rand(10..50)	
	puts "#{nom} a gagne #{points_de_vie} PV"
    # A faire:
    # - Gagner de la vie
    # - Affiche ce qu'il s'est passé
  end

  def ameliorer_degats
	
	@degats_bonus = rand(10..50)
	puts "#{@nom} a augmenté en puissance :\n #{@nom} a maintenant #{@degats_bonus} degats bonus par attaque"
    # A faire:
    # - Augmenter les dégats bonus
    # - Affiche ce qu'il s'est passé
  end
end

class Ennemi < Personne
	def initialize(nom)
		@degats = 0
		super(nom)
	end
	
  def degats
	@degats = rand(1..10)
    # A faire:
    # - Calculer les dégats
  end
end

class Jeu
  def self.actions_possibles(monde)
    puts "ACTIONS POSSIBLES :"

    puts "0 - Se soigner"
    puts "1 - Améliorer son attaque"

    # On commence à 2 car 0 et 1 sont réservés pour les actions
    # de soin et d'amélioration d'attaque
    i = 2
    monde.ennemis.each do |ennemi|
		if ennemi.en_vie == true
			puts "\n#{i} - Attaquer : "
			puts "#{ennemi.info}\n"
		i = i + 1
		end
    end
    puts "99 - Quitter"
  end

  def self.est_fini(joueur, monde)
	if (joueur.en_vie == false || monde.ennemis.size == 0)
			return true
		else 
			return false
		end
    # A faire:
    # - Déterminer la condition de fin du jeu
  end
end

class Monde
  attr_accessor :ennemis

  def ennemis_en_vie
	ennemis_temp=[];
		@ennemis.each do |ennemi|
			if ennemi.en_vie == true
				ennemis_temp << ennemi
			end
		end
		@ennemis = ennemis_temp
    # A faire:
    # - Ne retourner que les ennemis en vie
  end
end

##############

# Initialisation du monde
monde = Monde.new

# Ajout des ennemis
monde.ennemis = [
  Ennemi.new("Balrog"),
  Ennemi.new("Goblin"),
  Ennemi.new("Squelette")
]

# Initialisation du joueur
joueur = Joueur.new("Jean-Mich Mich")

# Message d'introduction. \n signifie "retour à la ligne"
puts "\n\nAinsi débutent les aventures de #{joueur.nom}\n\n"

# Boucle de jeu principale
100.times do |tour|
  puts "\n------------------ Tour numéro #{tour} ------------------"

  # Affiche les différentes actions possibles
  Jeu.actions_possibles(monde)

  puts "\nQUELLE ACTION FAIRE ?"
  # On range dans la variable "choix" ce que l'utilisateur renseigne
  choix = gets.chomp.to_i

  # En fonction du choix on appelle différentes méthodes sur le joueur
  if choix == 0
    joueur.soin
  elsif choix == 1
    joueur.ameliorer_degats
  elsif choix == 99
    # On quitte la boucle de jeu si on a choisi
    # 99 qui veut dire "quitter"
    break
  else
    # Choix - 2 car nous avons commencé à compter à partir de 2
    # car les choix 0 et 1 étaient réservés pour le soin et
    # l'amélioration d'attaque
    ennemi_a_attaquer = monde.ennemis[choix - 2]
    joueur.attaque(ennemi_a_attaquer)
  end

  puts "\nLES ENNEMIS RIPOSTENT !"
  # Pour tous les ennemis en vie ...
  monde.ennemis_en_vie.each do |ennemi|
    # ... le héro subit une attaque.
    ennemi.attaque(joueur)
  end

  puts "\nEtat du héro:"
  puts "#{joueur.info}\n"

  # Si le jeu est fini, on interompt la boucle
  break if Jeu.est_fini(joueur, monde)
end

puts "\nLe jeu est fini!\n"

# A faire:
# - Afficher le résultat de la partie

if joueur.en_vie
  puts "Vous avez gagné !"
else
  puts "Vous avez perdu !"
end




