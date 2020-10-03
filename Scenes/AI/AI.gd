extends "res://Scenes/Damageable.gd"



var player: RigidBody2D
var move = 5

func _ready():
	player = get_parent().get_parent().get_node("Player")
#	print(player)
	dustColor = Color.red
	move *= (randi() % 2) * 2 - 1
	$Timer.start(randf())

func _physics_process(_delta):
	apply_impulse(Vector2(0, 0), Vector2(move, 0))


func _on_Timer_timeout():
	$Timer.start(3)
	move *= -1
	apply_impulse(Vector2(0, 0), Vector2(0, -250))
	if is_instance_valid(player):
		FireAt(player.position - position)


