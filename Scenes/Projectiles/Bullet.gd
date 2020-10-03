extends Area2D


var speed = 24
var vel = Vector2()
var team: String = ""
var can_dmg = true

func _physics_process(_delta):
	position += vel

func SetVel(v: Vector2):
	vel = v
	vel *= speed
	vel *= Engine.time_scale

func _on_Bullet_body_entered(body):
	if body.is_in_group(Global.Damageable) and not body.is_in_group(team):
		body.splat(global_position)
		body.damage(1)
		end(body)
	elif body is StaticBody2D:
		end(body)
		

func end(body):
	disconnect("body_entered", self, "_on_Bullet_body_entered")
	if is_instance_valid(body):
		vel = Vector2(0, 0)
		$Light2D.queue_free()
		$Light2D.queue_free()
		$CollisionShape2D.queue_free()
		var former_rot = global_rotation
		get_parent().call_deferred("remove_child", self)
	
		body.call_deferred("add_child", self)
		position = body.to_local(global_position)
		rotation -= body.rotation
	else:
		queue_free()

func _on_Timer_timeout():
	queue_free()
