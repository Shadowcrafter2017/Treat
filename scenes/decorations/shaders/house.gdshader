shader_type canvas_item;

uniform vec4 origin : source_color;
uniform vec4 new : source_color;

void fragment() {
	// Place fragment code here.
	vec4 current_pixel = texture(TEXTURE, UV);
	
	if (current_pixel.r >= origin.r && current_pixel.g >= origin.g && current_pixel.b >= origin.b) {
		COLOR = new;
	}
	else {
		COLOR = current_pixel;
	}
}
