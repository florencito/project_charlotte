extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if self.is_in_group("door"):
			print("I'm a door")
			var door_animation: AnimatedSprite2D = self.get_node("AnimatedSprite2D")
			door_animation.play("open")
			body.win()
		else:
			queue_free()
