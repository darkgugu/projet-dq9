extends Node3D



# Ces variables apparaîtront dans l'Inspecteur de ton Player
@export var tshirt_scene: PackedScene
@export var armor_scene: PackedScene

# On suppose que tes slots sont des nœuds dans ta scène Player
@onready var armor_slot = $"../visuals/perso/armure_torse"

func _input(event):
	if event.is_action_pressed("equiper_1"):
		equip_item(tshirt_scene, armor_slot)
	elif event.is_action_pressed("equiper_2"):
		equip_item(armor_scene, armor_slot)
	elif event.is_action_pressed("desequiper"):
		unequip_item(armor_slot)
		
func unequip_item(slot: Node3D):
	# On vide simplement le slot
	for child in slot.get_children():
		child.queue_free()
	print("Équipement retiré avec succès.")

func equip_item(item_scene: PackedScene, slot: Node3D):
	for child in slot.get_children():
		child.queue_free()
	
	var new_item = item_scene.instantiate()
	slot.add_child(new_item)
	
	# RECHERCHE GÉNÉRIQUE :
	# Cette fonction parcourt toute l'arborescence de new_item
	# et s'arrête dès qu'elle trouve un objet de type MeshInstance3D
	var mesh_node = null
	
	# On cherche dans les enfants, petits-enfants, etc.
	var stack = [new_item]
	while stack.size() > 0:
		var node = stack.pop_back()
		if node is MeshInstance3D:
			mesh_node = node
			break # On a trouvé le Mesh, on arrête de chercher
		for child in node.get_children():
			stack.append(child)
			
	if mesh_node:
		var skeleton_node = get_parent().get_node("visuals/perso/Armature/Skeleton3D")
		mesh_node.skeleton = mesh_node.get_path_to(skeleton_node)
		print("Lien réussi pour : ", mesh_node.name)
	else:
		# Si on arrive ici, c'est que la scène ne contient VRAIMENT aucun MeshInstance3D
		print("ERREUR : Aucun MeshInstance3D trouvé dans ", item_scene.resource_path)
