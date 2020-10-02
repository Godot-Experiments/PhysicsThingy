extends "res://Scenes/Damageable.gd"

const MAXSPEED = 48
const MAXDIST = 160
var controllable = false

func _ready():
	set_pickable(true)
	hp = INF
	add_to_group(Global.Controllable)

func _physics_process(delta):
	if Global.weapon == Global.weapons.force and controllable and Input.is_action_pressed("click"):
		var dir: Vector2 = (get_global_mouse_position() - global_position)
		if dir.length() < MAXDIST:
#			print(dir.length())
			apply_impulse(Vector2(0, 0), -.15 *linear_velocity)
		dir.x = clamp(dir.x, -MAXSPEED, MAXSPEED)
		dir.y = clamp(dir.y, -MAXSPEED, MAXSPEED)
#		apply_central_impulse(dir)
		apply_impulse(Vector2(0, 0), dir)


func _on_BoxC_mouse_entered():
	controllable = true
	print("SLDFJ")
	disconnect("mouse_entered", self, "_on_BoxC_mouse_entered")


#func _on_BoxC_mouse_exited():
#	print("SFD")


