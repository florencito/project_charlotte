extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if self.is_in_group("door"):
			if body.has_key:
				var door_animation: AnimatedSprite2D = self.get_node("AnimatedSprite2D")
				door_animation.play("open")
				body.win()
				
			else:
				return
		else:
			body.has_key = true
			body.pickup_sound.play()
			print(body.has_key)
			queue_free()
