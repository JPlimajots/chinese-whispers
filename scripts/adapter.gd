extends Node2D

@onready var port_a: Area2D = $PortA
@onready var port_b: Area2D = $PortB

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	port_a.grid_pos = "ADAPT_A"
	port_b.grid_pos = "ADAPT_B"


func get_linked_port(entry_port: Area2D):
	if entry_port == port_a:
		return port_b
	elif entry_port == port_b:
		return port_a
	
	return null
