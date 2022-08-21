extends Node
class_name Roleplay

export(NodePath) onready var bunny = get_node(bunny) as KinematicBody
export(NodePath) onready var character = get_node(character) as Spatial

func roleplay_action_handler() -> void:
	if not bunny.is_on_floor():
		return
		
	if Input.is_action_just_pressed("action_1"):
		character.roleplay_behavior("Duck")
		
	if Input.is_action_just_pressed("action_2"):
		character.roleplay_behavior("No")
		
	if Input.is_action_just_pressed("action_3"):
		character.roleplay_behavior("Yes")
		
	if Input.is_action_just_pressed("action_4"):
		character.roleplay_behavior("Wave")
		
	if Input.is_action_just_pressed("action_5"):
		character.roleplay_behavior("Punch")
