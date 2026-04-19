class_name qudratoppator
extends Chorister


func _specific_math():
	return fmod(_phase*TAU,3)-fmod(_phase*TAU,12)#+sin(_phase*TAU)
