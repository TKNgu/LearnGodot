extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Stats
var score : int = 0

# Physics
var speed: int = 200
var jumpForce : int = 600
var gravity : int = 800

var vel : Vector2 = Vector2()
var grounded : bool = false

onready var sprite = $Sprite
onready var ui = get_node("/root/MainScene/CanvasLayer/UI")
onready var audio = $Coin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func die():
	get_tree().reload_current_scene()
	
func collect_coin(value):
	score += value
	audio.play()
	ui.set_score_text(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vel.x = 0
	if Input.is_action_pressed("move_right"):
		vel.x += speed
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
		
	vel.y += gravity * delta
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = -jumpForce
		
	vel = move_and_slide(vel, Vector2.UP)
	
	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false
