shader_type canvas_item;

/*
    GLITCH FX + Red Tint + Noise Pontilhado + Vinheta
*/

uniform float intensity : hint_range(0.0, 1.0) = 0.65;

// Glitch por blocos
uniform float block_size = 40.0;
uniform float block_shift = 0.03;

// Separação de cores
uniform float chroma_amount : hint_range(0.0, 0.1) = 0.02;

// Ruído pontilhado
uniform float noise_opacity : hint_range(0.0, 1.0) = 0.35;
uniform float noise_speed = 5.0;

// Roll
uniform bool roll_effect = true;
uniform float roll_speed = 6.0;
uniform float roll_size = 16.0;
uniform float roll_distort = 0.03;

// Warp CRT
uniform float warp_amount : hint_range(0.0, 5.0) = 1.0;

// Red Tint
uniform float red_tint : hint_range(0.0, 2.0) = 1.15;
uniform float green_drop : hint_range(0.0, 1.0) = 0.85;
uniform float blue_drop : hint_range(0.0, 1.0) = 0.8;

// Boost geral de brilho
uniform float brightness = 1.455;

// Vinheta
uniform float vignette_intensity = 0.58;
uniform float vignette_opacity : hint_range(0.0,1.0) = 0.59;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// ================= UTILITÁRIOS =================
float rand(vec2 co){
    return fract(sin(dot(co.xy, vec2(12.9898,78.233))) * 43758.5453);
}

float noise_fn(vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(
        mix(rand(i + vec2(0.0,0.0)), rand(i + vec2(1.0,0.0)), u.x),
        mix(rand(i + vec2(0.0,1.0)), rand(i + vec2(1.0,1.0)), u.x),
        u.y
    );
}

// Warp tipo CRT
vec2 warp(vec2 uv){
    vec2 delta = uv - 0.5;
    float dist2 = dot(delta, delta);
    float dist4 = dist2 * dist2;
    return uv + delta * dist4 * (warp_amount * 0.0015);
}

// Vinheta (igual ao shader CRT/VHS original)
float vignette_original(vec2 uv){
    uv *= 1.0 - uv;
    float v = uv.x * uv.y * 15.0;
    return pow(v, vignette_intensity * vignette_opacity);
}

// ================= FRAGMENT =================
void fragment() {
    vec2 uv = SCREEN_UV;

    // Warp CRT
    uv = warp(uv);

    // Glitch em blocos horizontais
    float block = floor(uv.y * block_size) / block_size;
    float shift = (rand(vec2(block, TIME)) - 0.5) * block_shift * intensity;
    uv.x += shift;

    // Roll VHS
    vec2 roll_uv = vec2(0.0);
    if (roll_effect) {
        float line = sin(uv.y * roll_size - TIME * roll_speed);
        line *= line * line;
        roll_uv.x = line * roll_distort * (1.0 - uv.x);
    }

    // Chroma shift
    vec2 uv_r = uv + roll_uv + vec2(chroma_amount, 0.0) * intensity;
    vec2 uv_g = uv + roll_uv;
    vec2 uv_b = uv + roll_uv + vec2(-chroma_amount, 0.0) * intensity;

    float r = textureLod(SCREEN_TEXTURE, uv_r, 0.0).r;
    float g = textureLod(SCREEN_TEXTURE, uv_g, 0.0).g;
    float b = textureLod(SCREEN_TEXTURE, uv_b, 0.0).b;

    vec4 color = vec4(r, g, b, 1.0);

    // Red Tint + Brilho
    color.r *= red_tint;
    color.g *= green_drop;
    color.b *= blue_drop;
    color.rgb *= brightness;

    // Noise pontilhado (sem lines)
    if (noise_opacity > 0.0) {
        float n = noise_fn(uv * vec2(200.0, 3.0) + TIME * noise_speed);
        color.rgb = mix(color.rgb, color.rgb + n * 0.5, noise_opacity);
    }

    // Vinheta
    color.rgb *= vignette_original(uv);

    COLOR = color;
}
