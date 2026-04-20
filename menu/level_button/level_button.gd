class_name LevelButton
extends Button

@onready var completion_mark: TextureRect = $CompletionMark

var level_idx: int = 0
var solved: bool = false


func mark_complete():
	self.completion_mark.show()
