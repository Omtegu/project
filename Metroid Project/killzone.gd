extends Area2D

@onready var timer =$Timer

func _on_area_entered(area):
	print ("DAMAGE TAKEN")
	timer.start()
	





func _on_timer_timeout():
	get_tree().reload_current_scene()
