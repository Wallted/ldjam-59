shader_type canvas_item;

uniform float zoom;
uniform vec2 center;
uniform vec2 c;
uniform float color_phase;
uniform float color_freq;

// constify later
uniform float thresh;
uniform float hue_coef;

#define OKLAB_TO_LMS_MATRIX mat3(vec3(1.0), vec3(0.3963377774, -0.1055613458, -0.0894841775), vec3(0.2158037573, -0.0638541728, -1.2914855480))
#define LMS_LINEAR_TO_RGB_MATRIX mat3(vec3(4.0767416621, -1.2684380046, -0.0041960863), vec3(-3.3077115913, 2.6097574011, -0.7034186147), vec3(0.2309699292, -0.3413193965, 1.7076147010))


float julia(vec2 uv, float zoom_adjusted)
{
	vec2 p = 2.0 * uv - vec2(1.0, 1.0);
	vec2 z = center + (p-center)*zoom_adjusted;
	
	float ld2 = 1.0;
	float lz2 = dot(z,z);
	for(int i=0; i<256; i++)
	{
		ld2 *= 4.0*lz2;
		z = vec2(z.x*z.x - z.y*z.y, 2.0*z.x*z.y) + c;
		lz2 = dot(z,z);
		if( lz2>thresh ) break;
	}
	return sqrt(lz2/ld2)*log(lz2);
}


#define F_STOP_SQUARE 1.0
#define MIN_FLOAT 1.17549435e-38
#define MAX_FLOAT 3.402823466e+38
#define EPSILON 0.00001


bool nearly_equal(float a, float b) {
	float absA = abs(a);
	float absB = abs(b);
	float diff = abs(a - b);

	if (abs(a - b) < EPSILON) { // shortcut, handles infinities
		return true;
	} else if (a == 0.0 || b == 0.0 || (absA + absB < MIN_FLOAT)) {
		// a or b is zero or both are extremely close to it
		// relative error is less meaningful here
		return diff < (EPSILON * MIN_FLOAT);
	} else { // use relative error
		return diff / min((absA + absB), MAX_FLOAT) < EPSILON;
	}
}


vec3 rgb_from_hsv(vec3 hsv) {
	vec3 rgb;
	int i;
	float f, p, q, t;

	if (nearly_equal(hsv.y, 0.0)) {
		rgb.r = rgb.g = rgb.b = hsv.z;
		return rgb;
	}

	hsv.x *= 6.0;
	hsv.x = mod(hsv.x, 6.0);
	i = int(floor(hsv.x));

	f = hsv.x - float(i);
	p = hsv.z * (1.0 - hsv.y);
	q = hsv.z * (1.0 - hsv.y * f);
	t = hsv.z * (1.0 - hsv.y * (1.0 - f));

	switch (i) {
		case 0: // Red is the dominant color
			rgb.r = hsv.z;
			rgb.g = t;
			rgb.b = p;
			break;
		case 1: // Green is the dominant color
			rgb.r = q;
			rgb.g = hsv.z;
			rgb.b = p;
			break;
		case 2:
			rgb.r = p;
			rgb.g = hsv.z;
			rgb.b = t;
			break;
		case 3: // Blue is the dominant color
			rgb.r = p;
			rgb.g = q;
			rgb.b = hsv.z;
			break;
		case 4:
			rgb.r = t;
			rgb.g = p;
			rgb.b = hsv.z;
			break;
		default: // (5) Red is the dominant color
			rgb.r = hsv.z;
			rgb.g = p;
			rgb.b = q;
			break;
	}

	return rgb;
}


vec3 rgb_from_oklch(vec3 oklch){
	vec3 oklab = vec3(oklch.x, oklch.y * cos(oklch.z), oklch.y * sin(oklch.z));
	vec3 lms = OKLAB_TO_LMS_MATRIX * oklab;
	vec3 lms_linear = pow(lms, vec3(3.0));
	vec3 rgb = pow(LMS_LINEAR_TO_RGB_MATRIX * lms_linear, vec3(1.0/1.19));
	return rgb;
}


void fragment() {
	
	float zoom_adjusted = pow(0.9, 50.0*zoom);
	float sdf = julia(UV, zoom_adjusted);
	float hue = fract(clamp(pow(sdf / zoom_adjusted, hue_coef + 0.1 * color_freq), 0.0, 1.0) * color_freq + color_phase);
	
	vec3 color = vec3(0.5 * (rgb_from_hsv(vec3(hue, 1.0, 1.0)) + rgb_from_oklch(vec3(0.7, 0.15, hue * TAU))));
	COLOR.rgb = color;
}