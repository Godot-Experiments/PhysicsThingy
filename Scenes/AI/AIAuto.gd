extends "res://Scenes/AI/AI.gd"

func _on_Timer_timeout():
	$Timer.start(.1)
#	move *= -1
#	apply_impulse(Vector2(0, 0), Vector2(0, -250))
	if is_instance_valid(player):
		fireAt(player)

