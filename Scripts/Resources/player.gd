extends CharacterBody3D

@export var speed: float = 20.0
@export var rotation_speed: float = 30.0
@onready var anim = $visuals/perso/AnimationPlayer
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Variable pour bloquer les entrées (ex: lors d'un dialogue)
var can_move: bool = true

func _physics_process(delta: float) -> void:
	if not can_move:
		velocity = Vector3.ZERO
		return
	if not is_on_floor():
		velocity.y -= gravity * 4.0 * delta

	# 1. On récupère la direction voulue par le joueur
	var direction = get_input_direction()
	
	# 2. On applique la physique de mouvement
	apply_movement(direction)
	
	# 3. On gère l'aspect visuel (rotation, animations)
	update_visuals(direction)
	
	move_and_slide()

# --- Fonctions découpées ---

func get_input_direction() -> Vector3:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	return Vector3(input_dir.x, 0, input_dir.y).normalized()

func apply_movement(direction: Vector3) -> void:
	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

func update_visuals(direction: Vector3) -> void:
	if direction != Vector3.ZERO:
		# Lissage de la rotation pour que ce soit moins brutal
		var target_rotation = atan2(-direction.x, -direction.z)
		rotation.y = lerp_angle(rotation.y, target_rotation, rotation_speed * get_process_delta_time())
		
		if anim.current_animation != "Running":
			anim.play("Running", 0.3)
	else:
		# Si le joueur est immobile, on lance "Idle"
		if anim.current_animation != "Idle":
			anim.play("Idle", 0.3)
	
	# Ici tu ajouterais tes appels d'animation (ex: $AnimationPlayer.play("Walk"))

# Fonction utilitaire pour bloquer le mouvement depuis l'extérieur
func set_input_enabled(enabled: bool) -> void:
	can_move = enabled
