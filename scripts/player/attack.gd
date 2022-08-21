extends Node
class_name Attack

onready var attack_cooldown: Timer = get_node("AttackCooldown")
onready var weapon_trigger: Timer = get_node("WeaponTrigger")

const PROJECTILE: PackedScene = preload("res://scenes/character/projectile.tscn")

export(NodePath) onready var bunny = get_node(bunny) as KinematicBody
export(NodePath) onready var character = get_node(character) as Spatial
export(NodePath) onready var projectile_spawner = get_node(projectile_spawner) as Position3D

func attack() -> void:
	if not bunny.is_on_floor():
		return
		
	if Input.is_action_just_pressed("shoot") and bunny.can_shoot:
		character.action_behavior("Idle_Shoot")
		bunny.is_weapon_triggered = true
		bunny.can_shoot = false
		attack_cooldown.start()
		weapon_trigger.start()
		spawn_projectile()
		
		
func spawn_projectile() -> void:
	var projectile = PROJECTILE.instance()
	projectile.bunny = bunny
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_transform = projectile_spawner.global_transform
	
	
func on_weapon_trigger_timeout() -> void:
	bunny.is_weapon_triggered = false
	
	
func on_attack_cooldown_timeout() -> void:
	bunny.can_shoot = true
