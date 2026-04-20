class_name Delailer
extends Chorister 
var i: int
var a:=0.0
var _aprev:=0.0
var it: int
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
	if _aprev==a and (it==0 or it==50):
		return a*(sin(_phase * TAU)+sin(_phase * TAU*1.5))
	else:
		if _aprev==0.0:
			it+=1
			if it==20:
				_aprev=1.0
			return it/20.0*(sin(_phase * TAU)+sin(_phase * TAU*1.5))
		else:
			it-=1
			if it==0:
				_aprev=0.0
			return (20.0-it)/20.0*(sin(_phase * TAU)+sin(_phase * TAU*1.5))
