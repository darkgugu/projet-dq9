extends Area3D

# Le nom du spawn point dans la scène du village
@export var destination_spawn_name: String = "SpawnDevantMaison"
@export_file("*.tscn") var village_scene_path: String

func _ready():
	# Connecte le signal "body_entered" au script
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Vérifie si c'est bien le joueur (en supposant qu'il soit dans un groupe "player")
	if body.is_in_group("Player"):
		# 1. On "enregistre" la destination dans le messager global
		SpawnName.next_spawn_name = destination_spawn_name
		
		# 2. On change de scène
		if village_scene_path != "":
			get_tree().change_scene_to_file(village_scene_path)
		else:
			push_error("Le chemin de la scène du village n'est pas défini sur la porte !")
