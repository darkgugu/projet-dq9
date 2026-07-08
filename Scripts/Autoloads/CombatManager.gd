extends Node

var monstre_a_combattre: Resource = null

func _ready():
	if CombatManager.monstre_a_combattre != null:
		var monstre = CombatManager.monstre_a_combattre
		print("Combat lancé contre : ", monstre.nom) # Ou autre propriété
		# Initialise ici ton interface avec les données du monstre
		
		# Optionnel : réinitialiser pour éviter de garder le monstre en mémoire
		CombatManager.monstre_a_combattre = null
