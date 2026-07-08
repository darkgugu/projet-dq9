extends Node3D
# On exporte pour choisir le nom du spawn par défaut dans l'inspecteur
@export var default_spawn_name: String = "PlayerSpawn"

func spawn_player(player: Node3D, spawn_name: String = default_spawn_name):
	# On cherche le Marker3D enfant qui porte le nom donné
	var spawn_node = get_node_or_null(spawn_name)

	if spawn_node:
		player.global_position = spawn_node.global_position
		# On peut aussi aligner la rotation si besoin
		player.global_rotation = spawn_node.global_rotation
	else:
		push_warning("Spawn point introuvable : " + spawn_name)
		
func _ready():
	# On attend une frame pour que tout soit prêt
	await get_tree().process_frame
	
	# On va chercher le joueur dans la scène (à adapter selon ton nom de nœud)
	var player = get_tree().current_scene.get_node("Player")
	
	var destination = SpawnName.next_spawn_name
	if player:
		spawn_player(player, destination)
		
	# Optionnel : On réinitialise au spawn par défaut pour la prochaine fois
	SpawnName.next_spawn_name = "PlayerSpawn"
