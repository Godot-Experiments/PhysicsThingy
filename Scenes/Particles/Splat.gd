extends Particles2D


var life


# Called when the node enters the scene tree for the first time.
func _ready():
	life = lifetime / speed_scale
	emitting = true
	$Dust.emitting = true

func _physics_process(delta):
	if life < lifetime and get_node_or_null("Aoe"):
		$Aoe.queue_free()
	life -= delta
	if life < 0:
		queue_free()


func _on_Aoe_body_entered(body):
	if body.is_in_group(Global.Damageable):
		body.apply_impulse(Vector2(0, 0), (body.position - position) * 8)
#		body.damage(10)
