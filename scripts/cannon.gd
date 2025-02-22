extends Node2D
## code for Cannon


@export var Cannonball : PackedScene

var cooldown = 1
var current_cooldown = cooldown


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass


# fire the cannonball
# temporarily removed - only to be used in rigidbody2d version
#func shoot():
#	var b = Cannonball.instantiate()
#	print("boom")
#	owner.add_child(b)
#	b.transform = $Marker2D.global_transform

