extends "res://Scenes/Projectiles/Bullet.gd"

var explosionRes = preload("res://Scenes/Projectiles/Explosion.tscn")

func _ready():
	vel *= .5
	
	$Trail.emitting = true
#	$Particles2D.set_as_toplevel(true)

#func _on_Bullet_body_entered(body):
#	if body.is_in_group(Global.Damageable) and not body.is_in_group(team):
#		body.splat(global_position)
#		body.damage(0)
##		var trail = $Trail
##		remove_child(trail)
#
#
##		self.set_owner(body)
#
#		end()
#
#	elif body is StaticBody2D:
#		end()

func end(body):
	var ex = explosionRes.instance()
	ex.position = position
	get_tree().get_root().call_deferred("add_child", ex)
	.end(body)
#	get_parent().queue_free()
