class_name Led
extends TextureRect
const DIODE = preload("uid://dmmrb272adx8f")
const DIODE_GREEN = preload("uid://dem73ctn6s6uy")
const DIODE_GREEN_BRIGHT = preload("uid://0pnvhm8gukm")

enum State {
	OFF=0,
	DIM=1,
	ON=2,
}
var state: State = State.OFF;


func _set_state(_state: State):
	self.state = _state
	self.texture = {
		State.OFF: DIODE,
		State.DIM: DIODE_GREEN,
		State.ON: DIODE_GREEN_BRIGHT,
	}[state]
	
func reset():
	_set_state(State.OFF)

func enable():
	_set_state(State.ON)
	
func disable():
	if self.state == State.OFF:
		return
	_set_state(State.DIM)
		
