extends CharacterBody2D

var speed = 30
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("walk")
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
		

func _on_detection_aera_body_entered(body):
	player = body
	player_chase = true


func _on_detection_aera_body_exited(body):
	player = null
	player_chase = false

#连接节点触发之后 史莱姆碰到玩家会被击退
#func _on_hitbox_area_entered(area):
	#player = area
	#player_chase = true
