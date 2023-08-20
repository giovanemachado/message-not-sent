extends SubViewport

@onready var cam = $Camera2D
@onready var sub = $"../../../../../Submarine"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	cam.position = sub.position
