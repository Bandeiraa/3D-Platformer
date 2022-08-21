extends KinematicBody
class_name Bunny

onready var move_state: Node = get_node("States/Move")
onready var attack_state: Node = get_node("States/Attack")
onready var roleplay_state: Node = get_node("States/Roleplay")

onready var camera_arm: SpringArm = get_node("CameraArm")
onready var character: Spatial = get_node("CharacterWithGun")

var max_health: int

var can_move: bool = true
var can_shoot: bool = true
var can_interact: bool = true

var is_weapon_triggered: bool = false

var velocity: Vector3 = Vector3.ZERO
var snap_vector: Vector3 = Vector3.DOWN

export(int) var health = 25

export(float) var speed = 7.0

export(float) var gravity = 50.0
export(float) var jump_speed = 20.0

export(float) var rotation_speed = 5.0

func _ready() -> void:
	max_health = health
	
	
func _physics_process(delta: float) -> void:
	move_state.horizontal_movement()
	move_state.vertical_movement(delta)
	#Move with snap(With this the character is able to walk in slopes)
	velocity = move_and_slide_with_snap(
		velocity,
		snap_vector,
		Vector3.UP,
		true
	)
	
	#Method related to Attack e.g: shoot
	attack_state.attack()
	
	#Roleplay Animations(Just for fun)
	roleplay_state.roleplay_action_handler()
	
	rotate_character(delta)
	character.animate(Vector2(velocity.x, velocity.z))
	
	
func _process(_delta: float) -> void:
	camera_arm.translation = translation
	
	
#Rotate character based on AIM(Mouse)
func rotate_character(delta: float) -> void:
	#Only rotates based on this condition(Prevents to look at some default direction when calls a Jump)
	if Vector2(velocity.z, velocity.x).length() > 0.2:
		var look_direction: Vector2 = Vector2(velocity.z, velocity.x)
		rotation.y = lerp_angle(rotation.y, look_direction.angle(), delta * rotation_speed)
		
		
func on_hitbox_area_entered(area) -> void:
	area.invulnerability_countdown(true)
	update_health(area.damage, "decrease")
	
	
func update_health(value: int, type: String) -> void:
	if not can_interact:
		return
		
	match type:
		"increase":
			health = clamp(health + value, 0, max_health)
			return
			
		"decrease":
			health = clamp(health - value, 0, max_health)
			
	if health == 0:
		can_interact = false
		character.action_behavior("Death")
		return
		
	character.action_behavior("HitReact")
