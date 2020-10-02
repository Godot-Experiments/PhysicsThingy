extends Area2D


var speed = 24
var vel = Vector2()
var team: String = ""

func _physics_process(delta):
	position += vel


func _on_Bullet_body_entered(body):
	if body.is_in_group(Global.Damageable) and not body.is_in_group(team):
		body.splat(global_position)
		body.damage(2)
		queue_free()
	elif body is StaticBody2D:
		queue_free()


func _on_Timer_timeout():
	queue_free()
