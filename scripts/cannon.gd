extends Node2D

@export var Cannonball : PackedScene

var cooldown = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	Cannonball = load("res://scenes/cannonball.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	cooldown -= delta
	if cooldown <= 0:
		shoot()
		cooldown = 1.0

# fire the cannonball
func shoot():
	var b = Cannonball.instantiate()
	owner.add_child(b)
	b.transform = $Marker2D.global_transform
	
