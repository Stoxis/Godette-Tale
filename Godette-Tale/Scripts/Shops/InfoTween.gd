extends Panel

onready var tween = $Tween

func appear():
	print("appear")
	tween.interpolate_property(self, "rect_position:y", 0, -162,
								0.5, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
	tween.start()

func disappear():
	tween.interpolate_property(self, "rect_position:y", -162, 0,
								0.5, Tween.TRANS_QUART, Tween.EASE_IN_OUT)
	tween.start()
