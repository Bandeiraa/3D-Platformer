extends KinematicBody
class_name Enemy

onready var ray: RayCast = get_node("Ray")
onready var hurtbox: Area = get_node("Hurtbox")

var player_ref: KinematicBody = null

var is_alive: bool = true

var y_direction: float = 0

var max_health: int
var velocity: Vector3

export(int) var speed
export(int) var health
export(int) var gravity
export(int) var rotation_speed

export(int) var damage

export(float) var distance_threshold

export(NodePath) onready var enemy_instance = get_node_or_null(enemy_instance) as Spatial

func _ready() -> void:
	max_health = health
	
	
func update_health(value: int) -> void:
	if not is_alive:
		return
		
	health = clamp(health - value, 0, max_health)
	if health == 0:
		is_alive = false
		hurtbox.change_collision_state(true)
		enemy_instance.action_behavior("Death")
		return
		
	enemy_instance.action_behavior("HitRecieve")
	
	
func get_player_ref(player: KinematicBody) -> void:
	player_ref = player
	
	
func _physics_process(delta: float) -> void:
	if player_ref == null or not is_alive:
		return
		
	var is_colliding: bool = verify_collision()
	
	var move_dir: Vector3 = verify_movement(delta)
	velocity = move_dir * speed
	rotate_enemy(delta)
	
	if not is_colliding:
		enemy_instance.move_behavior(Vector3.ZERO)
		return
		
	if can_chase():
		velocity = move_and_slide(velocity, Vector3.DOWN)
		enemy_instance.move_behavior(velocity)
		return
		
	enemy_instance.move_behavior(Vector3.ZERO)
	
	
func can_chase() -> bool:
	var distance_to: float = translation.distance_to(player_ref.translation)
	if distance_threshold < distance_to:
		return true
		
	return false
		
		
func verify_collision() -> bool:
	if ray.is_colliding() and ray.get_collider().name == "Bunny":
		return true
		
	return false
	
	
func verify_movement(delta: float) -> Vector3:
	var player_direction = translation.direction_to(player_ref.translation)
	var x_direction = player_direction.x
	var z_direction = player_direction.z
	
	y_direction -= gravity * delta
	
	return Vector3(x_direction, y_direction, z_direction)
	
	
func rotate_enemy(delta: float) -> void:
	#Only rotates based on this condition(Prevents to look at some default direction when calls a Jump)
	if Vector2(velocity.z, velocity.x).length() > 0.2:
		var look_direction: Vector2 = Vector2(velocity.z, velocity.x)
		rotation.y = lerp_angle(rotation.y, look_direction.angle(), delta * rotation_speed)
