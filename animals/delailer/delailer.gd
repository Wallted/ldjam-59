class_name Delailer
extends Chorister 
var i: float
var a:=1.0

func _specific_math():
	#if i<self.grid_position.y/grid_size.y*3000+1500:
		#i+=1
	#else :
		#i=0
		#a+=1
		#a=fmod(a,2)
	if i<self.grid_position.y/EFFECT_MAX_GRID_SIZE*3000+1500:
		i+=1
	else :
		i=0
		a+=1
		a=fmod(a,2)
	return a*(sin(_phase * TAU)+sin(_phase * TAU*1.5))
