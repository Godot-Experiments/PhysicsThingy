extends "res://Scenes/Damageable.gd"

var speed = 10
var jump = 704
var fall = 64
var turnspeed = 5
var wIndex = 0

var rocketRes = preload("res://Scenes/Projectiles/Rocket.tscn")
var explosion = preload("res://Scenes/Projectiles/Explosion.tscn")

var wDic: Dictionary = {0: "Telekinesis", 1: "Rocket", 2: "Autogun"}

#var dustRes = preload("res://Test/DustShower.tscn")
#var dustColor = Color.red

func _ready():
	hp = 10
	dustColor = Color.red
	add_to_group(Global.T1)
#	add_to_group(Global.Damageable)
#	var pm: PhysicsMaterial = PhysicsMaterial.new()
#	pm.friction = 0
#	physics_material_override = pm

func SwitchWeapon(index):
	wIndex = (index) % Global.weapons.size()
	Global.weapon = Global.weapons.values()[wIndex]
	$Cam/Weap.text = "Weapon: " + wDic[wIndex]

func damage(dmg: float):
	.damage(dmg)
	$Cam/HP.text = "HP: " + str(hp)

func _physics_process(_delta):
	if Input.is_action_just_pressed("bullet_time"):
		Engine.time_scale /= 2
	elif Input.is_action_just_released("bullet_time"):
		Engine.time_scale *= 2
	
	if Input.is_action_just_pressed("ui_focus_next"):
		SwitchWeapon(wIndex - 1)
	elif Input.is_action_just_pressed("ui_focus_prev"):
		SwitchWeapon(wIndex + 1)
	elif Input.is_key_pressed(KEY_1):
		SwitchWeapon(0)
	elif Input.is_key_pressed(KEY_2):
		SwitchWeapon(1)
	elif Input.is_key_pressed(KEY_3):
		SwitchWeapon(2)
		
	if (Global.weapon == Global.weapons.rocket and Input.is_action_just_pressed("click")) or Input.is_action_just_pressed("rclick"):
		FireAt(get_global_mouse_position() - global_position, Global.T1, rocketRes)
	elif Global.weapon == Global.weapons.gun:
		if $Timer.is_stopped() and Input.is_action_pressed("click"):
			$Timer.start()
			FireAt(get_global_mouse_position() - global_position, Global.T1)
		
	$Ground.rotation = -rotation
	$Ground2.rotation = -rotation
	$Ground3.rotation = -rotation
	$Cam.rotation = -rotation
#	if Input.is_action_pressed("ui_left"):
#		apply_central_impulse(Vector2(-speed, 0))
#	if Input.is_action_pressed("ui_right"):
#		apply_central_impulse(Vector2(speed, 0))
#	if Input.is_action_just_pressed("ui_up"):
#		apply_central_impulse(Vector2(0, -jump))
#	if Input.is_action_just_pressed("ui_down"):
#		apply_central_impulse(Vector2(0, jump))
	if $Ground.is_colliding() or $Ground2.is_colliding() or $Ground3.is_colliding():
		MoveLateral()
		MoveUp()
	else:
		MoveLateral(.125)
	MoveDown()

func MoveDown():
	if Input.is_action_pressed("ui_down"):
		apply_impulse(Vector2(0, 0), Vector2(0, fall))

func MoveUp():
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_select"):
		apply_impulse(Vector2(0, 0), Vector2(0, -jump))


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


func _on_Damageable_body_entered(body):
	pass
#	if is_instance_valid(body):
##		print(body.name)
#		if body.is_in_group(Global.Damageable):
#			var vel = body.linear_velocity.length() / 64
#	#		print(vel)
#			if vel > 6:
#				damage(vel)
