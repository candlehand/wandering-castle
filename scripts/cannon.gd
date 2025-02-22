extends Node2D

@export var Cannonball : PackedScene

var cooldown = 1
var current_cooldown = cooldown

# Called when the node enters the scene tree for the first time.
func _ready():
	Cannonball = load("res://scenes/cannonball.tscn")
	print("Cannon, ready!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	current_cooldown -= delta
	if current_cooldown <= 0:
		shoot()
		current_cooldown = cooldown


# fire the cannonball
# to-do: disable shooting while placing is happening
func shoot():
	var b = Cannonball.instantiate()
	print("boom")
	owner.add_child(b)
	b.transform = $Marker2D.global_transform

