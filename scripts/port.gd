extends Area2D

var connected_pin: Area2D = null

func is_occupied():
	return connected_pin != null
