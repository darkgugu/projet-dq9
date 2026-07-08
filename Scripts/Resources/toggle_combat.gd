extends Area3D
@export var donnees_monstre: Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Le script du piège est bien vivant !")
	pass # Replace with function body.
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	# Regarde dans ta console pour voir quel objet a triché au lancement !
	print("Objet qui a touché la zone : ", body.name)
	
	# SÉCURITÉ : On n'applique les dégâts QUE si le nom de l'objet contient "Joueur" ou "CharacterBody3D"
	# (Adapte les mots entre guillemets si le nœud de ton personnage a un autre nom)
	if "player" in body.name or "CharacterBody3D" in body.name:
		CombatManager.monstre_a_combattre = donnees_monstre
		print(CombatManager.monstre_a_combattre.nom)
		lancer_combat()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func lancer_combat():
	print("combat lancer")
	# Ici, tu appelles ta logique de combat
	# Par exemple, changer de scène ou afficher une interface
	get_tree().change_scene_to_file("res://Scenes/Levels/village_1.tscn")

func _process(delta: float) -> void:
	pass
