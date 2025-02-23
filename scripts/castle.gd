extends AnimatableBody2D
## Handles player castle movement
## and all other castle specific actions in code

var keep_hp = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_cannonball_keep_hit():
	print("Keep hit!")
	keep_hp -= 1
	pass
