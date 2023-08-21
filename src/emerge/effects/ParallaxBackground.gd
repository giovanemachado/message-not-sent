extends ParallaxBackground


@onready var cloud_layer = $ParallaxLayer
@onready var cloud_layer2 = $ParallaxLayer2

func _process(delta):
	cloud_layer.motion_offset.x += 2.5 * delta
	cloud_layer2.motion_offset.x += 7.5 * delta
