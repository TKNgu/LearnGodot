extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var value = 1
var time_out : int = 0
var count : int = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees += 90 * delta
	if time_out > 0:
		time_out -= delta
	visible = time_out <= 0


func _on_Coin_body_entered(body):
	if body.name == "Player" and visible:
		body.collect_coin(value)
		time_out = 100
		count -= 1
		if count == 0:
			queue_free()
