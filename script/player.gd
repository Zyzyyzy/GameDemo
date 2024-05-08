extends CharacterBody2D

const accel = 800
#最大速度
const max_speed = 110
const friction = 600

var velocity2 = Vector2.ZERO

@onready var state_machine = $AnimationTree.get("parameters/playback")

func _ready():
	$AnimationTree.active = true
	$AnimationTree.set("parameters/idel/blend_position", Vector2.DOWN)
#玩家行动逻辑
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	input_vector.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity2 = velocity2.move_toward(input_vector * max_speed, accel * delta)
		$AnimationTree.set("parameters/idel/blend_position", input_vector)
		$AnimationTree.set("parameters/move/blend_position", input_vector)
		state_machine.travel("move")
	else:
		velocity2 = velocity2.move_toward(Vector2.ZERO, friction * delta)
		state_machine.travel("idel")
		
	move_and_collide(velocity2 * delta)
