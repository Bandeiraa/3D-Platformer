extends Node
class_name Move

export(NodePath) onready var bunny = get_node(bunny) as KinematicBody
export(NodePath) onready var character = get_node(character) as Spatial
export(NodePath) onready var camera_arm = get_node(camera_arm) as SpringArm

func horizontal_movement() -> void:
	if not bunny.can_move:
		return
		
	var aux_direction: Vector2 = Vector2.ZERO
	var move_direction: Vector3 = Vector3.ZERO
	
	aux_direction = get_direction()
	
	move_direction.x = aux_direction.x
	move_direction.z = aux_direction.y
	move_direction = move_direction.rotated(Vector3.UP, camera_arm.rotation.y).normalized()
	
	bunny.velocity.x = move_direction.x * bunny.speed
	bunny.velocity.z = move_direction.z * bunny.speed
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	
func vertical_movement(delta: float) -> void:
	bunny.velocity.y -= bunny.gravity * delta
	
	var just_landed: bool = bunny.is_on_floor() and bunny.snap_vector == Vector3.ZERO
	var is_jumping: bool = bunny.is_on_floor() and Input.is_action_just_pressed("ui_select")
	
	#Jump
	if is_jumping:
		character.action_behavior("Jump")
		
	#Fall Land
	if just_landed and bunny.velocity.y < 0:
		bunny.snap_vector = Vector3.DOWN
		character.action_behavior("Jump_Land")
		
	#Fall without Jump
	if not character.on_action and abs(bunny.velocity.y) > 10.0:
		character.action_behavior("Jump_Idle")
		bunny.snap_vector = Vector3.ZERO
		
		
func jump() -> void:
	bunny.velocity.y = bunny.jump_speed
	bunny.snap_vector = Vector3.ZERO
