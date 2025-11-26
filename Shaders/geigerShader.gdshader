shader_type spatial;
render_mode unshaded, cull_disabled, blend_mix, depth_draw_never;

uniform float wave_amplitude = 0.25;
uniform float wave_frequency = 40.0;
uniform float wave_speed = 9.0;

uniform float left_falloff = 1.0;
uniform float right_falloff = 1.0;

uniform float thickness = 0.1;
uniform vec3 tint : source_color = vec3(0, 0, 0);

uniform float pixel_size = 128.0;

void fragment() {
    // Pixelar UV
    vec2 uv = floor(UV * pixel_size) / pixel_size;

    float dist_left = clamp(0.5 - uv.x, 0.0, 0.5) * 2.0;
    float dist_right = clamp(uv.x - 0.5, 0.0, 0.5) * 2.0;

    float falloff_left = pow(1.0 - dist_left, left_falloff);
    float falloff_right = pow(1.0 - dist_right, right_falloff);

    float center_falloff = (uv.x <= 0.5) ? falloff_left : falloff_right;

    float amp = wave_amplitude * center_falloff;
    float y = 0.5 + sin(uv.x * wave_frequency + TIME * wave_speed) * amp;

    float dist = abs(uv.y - y);

    // Borda dura (sem blur)
    float alpha = dist < thickness ? 1.0 : 0.0;

    ALBEDO = tint * alpha;
    ALPHA = alpha;
}
