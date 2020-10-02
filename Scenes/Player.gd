extends "res://Scenes/Damageable.gd"

var speed = 10
var jump = 704
var fall = 64
var turnspeed = 5
var wIndex = 0

var explosion = preload("res://Scenes/Projectiles/Explosion.tscn")

#var dustRes = preload("res://Test/DustShower.tscn")
#var dustColor = Color.red

func _ready():
	hp = INF
	dustColor = Color.red
	add_to_group(Global.T1)
#	add_to_group(Global.Damageable)
#	var pm: PhysicsMaterial = PhysicsMaterial.new()
#	pm.friction = 0
#	physics_material_override = pm

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		wIndex = (wIndex + 1) % Global.weapons.size()
		Global.weapon = Global.weapons.values()[wIndex]
	if Input.is_action_just_pressed("click"):
		if Global.weapon == Global.weapons.rocket:
			var expl = explosion.instance()
			expl.global_position = get_global_mouse_position()
			get_tree().get_root().add_child(expl)
		elif Global.weapon == Global.weapons.gun:
			FireAt(get_global_mouse_position() - global_position, Global.T1)
		
	$RayCast2D.rotation = -rotation
#	if Input.is_action_pressed("ui_left"):
#		apply_central_impulse(Vector2(-speed, 0))
#	if Input.is_action_pressed("ui_right"):
#		apply_central_impulse(Vector2(speed, 0))
#	if Input.is_action_just_pressed("ui_up"):
#		apply_central_impulse(Vector2(0, -jump))
#	if Input.is_action_just_pressed("ui_down"):
#		apply_central_impulse(Vector2(0, jump))
	if get_node("RayCast2D").is_colliding():
		MoveLateral()
	else:
		MoveLateral(.125)
	if Input.is_action_just_pressed("ui_up"):
		apply_impulse(Vector2(0, 0), Vector2(0, -jump))
	if Input.is_action_pressed("ui_down"):
		apply_impulse(Vector2(0, 0), Vector2(0, fall))

func MoveLateral(modifier=1):
	if Input.is_action_pressed("ui_left"):
		var move = -speed * modifier
		if abs(linear_velocity.x) < 256:
			move *= turnspeed
		if linear_velocity.x > 0:
			move *= turnspeed
		apply_impulse(Vector2(0, 0), Vector2(move, 0))
	elif Input.is_action_pressed("ui_right"):
		var move = speed * modifier
		if abs(linear_velocity.x) < 256:
			move *= turnspeed
		if linear_velocity.x < 0:
			move *= turnspeed
		apply_impulse(Vector2(0, 0), Vector2(move, 0))

