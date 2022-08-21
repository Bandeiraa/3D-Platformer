extends Node

var coins: int
var stars: int
var gems: int

func update_coins() -> void:
	coins += 1
	get_tree().call_group("interface", "update_collectable", "Coins", str(coins))
	
	
func update_stars() -> void:
	stars += 1
	get_tree().call_group("interface", "update_collectable", "Stars", str(stars))
	
	
func update_gems(type: String) -> void:
	match type:
		"Blue":
			gems += 1
			
		"Green":
			gems += 3
			
		"Pink":
			gems += 5
			
	get_tree().call_group("interface", "update_collectable", "Gems", str(gems))
