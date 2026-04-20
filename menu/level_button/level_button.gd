class_name LevelButton
extends Button

@onready var completion_mark: TextureRect = $CompletionMark
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var level_idx: int = 0
var is_completed: bool = false


func mark_complete():
	self.completion_mark.show()
	self.is_completed = true

func mark_animal(idx):
	animated_sprite.show()
	var res_list = Species.ChoristerResMapPreload[idx]
	animated_sprite.sprite_frames.add_frame('idle', res_list[0])
	animated_sprite.sprite_frames.add_frame('idle', res_list[1])
	animated_sprite.play('idle')
