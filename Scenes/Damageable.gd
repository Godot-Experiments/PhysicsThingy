extends RigidBody2D

var dustRes = preload("res://Scenes/Particles/Splat.tscn")
var hp = 10
var dustColor = Color.white

var bulletRes = preload("res://Scenes/Projectiles/Bullet.tscn")

func _ready():
	add_to_group(Global.Damageable)
	dustRes.instance().queue_free()


func splat(pos: Vector2 = Vector2(INF, INF)):
	var dust = dustRes.instance()
	dust.modulate = dustColor
	if pos == Vector2(INF, INF):
		dust.position = position
	else:
		dust.global_position = pos
	get_tree().get_root().add_child(dust)

func damage(dmg: float):
	hp -= dmg
	splat()
	if hp <= 0:
		queue_free()
#func _on_Box_body_shape_entered(body_id, body, body_shape, local_shape):
#	print(body.name)

func _on_Damageable_body_entered(body):
	if is_instance_valid(body):
#		print(body.name)
		if body.is_in_group(Global.Damageable):
			var vel = body.linear_velocity.length() / 64
	#		print(vel)
			if vel > 6:
				damage(vel)

func FireAt(pos: Vector2, team: String=Global.T2):
	var bullet = bulletRes.instance()
	bullet.team = team
	var vel = pos.normalized()
	bullet.position = position + vel * .9
	bullet.vel = vel * bullet.speed
	bullet.rotation = vel.angle()
	get_tree().get_root().add_child(bullet)
