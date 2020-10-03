extends Node2D




func _on_Area2D_body_entered(body):
	if body.is_in_group(Global.T1):
		$AI/AIAuto.get_node("Timer").start(.2)
		$BossDetect.queue_free()
