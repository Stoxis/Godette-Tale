extends KinematicBody2D
class_name Player

var moveSpeed : int = 192

var vel : Vector2 = Vector2()
var facingDir : Vector2 = Vector2()

onready var dialogue = get_node("/root/Root_Node/CanvasLayer/panel")
onready var save = get_node("/root/Root_Node/CanvasLayer/savePanel")

func _ready():
	self.set_position(SceneChanger._playerPosition) #After transitioning to a new scene go to the preset position for that transition mask

func _physics_process (delta):
	
	vel = Vector2()
	
	# inputs
	var isMoving : bool = false
	if !dialogue.is_visible() && !save.is_visible():
		var isDiagonal: bool = false
		if Input.is_action_pressed("move_up"):
			vel.y -= 1
			facingDir = Vector2(0, -1)
			isMoving = true
		if Input.is_action_pressed("move_down"):
			vel.y += 1
			facingDir = Vector2(0, 1)
			isMoving = true
		if Input.is_action_pressed("move_left"):
			vel.x -= 1
			facingDir = Vector2(-1, 0)
			isMoving = true
		if Input.is_action_pressed("move_right"):
			vel.x += 1
			facingDir = Vector2(1, 0)
			isMoving = true
		
		# Direction Conflict Handling
		if Input.is_action_pressed("move_up") && Input.is_action_pressed("move_down") && vel.x == 1: #player velocity is right
			vel.y -= 1
			facingDir = Vector2(1, 0)
			isMoving = true
		elif Input.is_action_pressed("move_up") && Input.is_action_pressed("move_down") && vel.x == -1: #player velocity is left
			vel.y -= 1
			facingDir = Vector2(-1, 0)
			isMoving = true
		elif Input.is_action_pressed("move_up") && Input.is_action_pressed("move_down"):
			vel.y -= 1
			facingDir = Vector2(0, -1)
			isMoving = true

		if Input.is_action_pressed("move_left") && Input.is_action_pressed("move_right") && vel.y == 1: #player velocity is down
			vel.x -= 1
			facingDir = Vector2(0, 1) #face up
			isMoving = true
		elif Input.is_action_pressed("move_left") && Input.is_action_pressed("move_right") && vel.y == -1: #player velocity is up
			vel.x -= 1
			facingDir = Vector2(0, -1) #face down
			isMoving = true
		elif Input.is_action_pressed("move_left") && Input.is_action_pressed("move_right"):
			vel.x -= 1
			facingDir = Vector2(-1, 0)
			isMoving = true
		
			
		if isMoving:
			var currentAnim = $AnimationPlayer.current_animation
			if Input.is_action_pressed("move_up") && Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_down") && !Input.is_action_pressed("move_right"): #Up Left
				isDiagonal = true
				if currentAnim != "Left" and currentAnim != "Up":
					$AnimationPlayer.play("Up")
				if $AnimationPlayer.current_animation == "Up":
					$AnimationPlayer.play("Up")
				if $AnimationPlayer.current_animation == "Left":
					$AnimationPlayer.play("Left")
			if Input.is_action_pressed("move_up") && Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_down") && !Input.is_action_pressed("move_left"): #Up Right
				isDiagonal = true
				if currentAnim != "Right" and currentAnim != "Up":
					$AnimationPlayer.play("Up")
				if $AnimationPlayer.current_animation == "Up":
					$AnimationPlayer.play("Up")
				if $AnimationPlayer.current_animation == "Right":
					$AnimationPlayer.play("Right")
			if Input.is_action_pressed("move_down") && Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_up") && !Input.is_action_pressed("move_right"): #Down Left
				isDiagonal = true
				if currentAnim != "Down" and currentAnim != "Left":
					$AnimationPlayer.play("Down")
				if $AnimationPlayer.current_animation == "Down":
					$AnimationPlayer.play("Down")
				if $AnimationPlayer.current_animation == "Left":
					$AnimationPlayer.play("Left")
			if Input.is_action_pressed("move_down") && Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_up") && !Input.is_action_pressed("move_left"): #Down Right
				isDiagonal = true
				if currentAnim != "Down" and currentAnim != "Right":
					$AnimationPlayer.play("Down")
				if $AnimationPlayer.current_animation == "Down":
					$AnimationPlayer.play("Down")
				if $AnimationPlayer.current_animation == "Right":
					$AnimationPlayer.play("Right")
			if !isDiagonal:
				if facingDir == Vector2(0, -1): #Up
					if $AnimationPlayer.current_animation != "Up":
						$AnimationPlayer.play("Up")
				if facingDir == Vector2(0, 1): #Down
					if $AnimationPlayer.current_animation != "Down":
						$AnimationPlayer.play("Down")
				if facingDir == Vector2(-1, 0): #Left
					if $AnimationPlayer.current_animation != "Left":
						$AnimationPlayer.play("Left")
				if facingDir == Vector2(1, 0): #Right
					if $AnimationPlayer.current_animation != "Right":
						$AnimationPlayer.play("Right")
		#normalize the velocity to prevent faster diagonal movement
		vel = vel.normalized()
		
		# move the player
		move_and_slide(vel * moveSpeed)
	
	# stop walk animation when standing still
	if(!isMoving):
		$AnimationPlayer.stop()
		$AnimationPlayer.seek(0.8, true)
