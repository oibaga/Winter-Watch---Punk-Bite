shader_type spatial;

render_mode 
    unshaded,
    cull_front,
    //depth_draw_always, // 🔥 IGNORA PAREDES E OBJETOS NA FRENTE
    depth_draw_always;   // 🔥 NÃO ESCREVE NO DEPTH BUFFER

uniform bool active = true;

uniform vec4 outline_color : source_color = vec4(1.0);
uniform float outline_width = 1.0;

void vertex() {
    if (!active) {
        POSITION = PROJECTION_MATRIX * (MODELVIEW_MATRIX * vec4(VERTEX, 1.0));
    } else {
        vec4 clip_position = PROJECTION_MATRIX * (MODELVIEW_MATRIX * vec4(VERTEX, 1.0));
        vec3 clip_normal = mat3(PROJECTION_MATRIX) * (mat3(MODELVIEW_MATRIX) * NORMAL);

        vec2 offset = normalize(clip_normal.xy) * outline_width * clip_position.w / VIEWPORT_SIZE;

        clip_position.xy += offset;

        POSITION = clip_position;
    }
}

void fragment() {
    ALBEDO = outline_color.rgb;
    ALPHA = outline_color.a;
}
