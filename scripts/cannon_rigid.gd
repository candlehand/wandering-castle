extends RigidBody2D
## controls rigidbody cannon- physics based cannon

@export var Cannonball : PackedScene

var cooldown = 1
var current_cooldown = cooldown
var paused = false
var default_rotation: float = deg_to_rad(-12)

signal keep_hit
***********

# Called when the node enters the scene tree for the first time.
func _ready():
	Cannonball = load("res://scenes/cannonball.tscn")
	print($Marker2D.rotation)
	print($".".rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var parent_rotation = get_parent().rotation
	$Marker2D.rotation = parent_rotation + default_rotation
	# handles shooting/cooldown
	current_cooldown -= delta
	if current_cooldown <= 0:
		shoot()
		current_cooldown = cooldown


# fire the cannonball
func shoot():
	
	#instantiate a new cannonball
	var b = Cannonball.instantiate()
	print("boom")
	# connect the cannonball symbol to be forwarded ->
	b.connect("keep_hit", _on_cannonball_keep_hit)
	# add the instance to the scene
	get_tree().get_root().add_child(b)
	# make it come out of the marker
	b.transform = $Marker2D.global_transform


# send a signal if the keep is hit
func _on_cannonball_keep_hit():
	keep_hit.emit()
