extends "res://Scenes/AI/AI.gd"

func _ready():
	$Timer.stop()

func _on_Timer_timeout():
	$Timer.start(.2)
#	move *= -1
#	apply_impulse(Vector2(0, 0), Vector2(0, -250))
	if is_instance_valid(player):
		FireAt(player.position - position)

