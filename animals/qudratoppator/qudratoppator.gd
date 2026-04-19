class_name qudratoppator
class_name Qudratoppator
extends Chorister


func _specific_math():
	return fmod(_phase*TAU,3)-fmod(_phase*TAU,12)#+sin(_phase*TAU)
