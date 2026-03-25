precision highp float;

varying vec3 vNormal;
varying vec3 vWorldNormal;
varying vec2 vUv;
varying vec3 vColor;
varying vec3 vPos;

uniform vec2 iResolution;
uniform vec2 u_mouse;
uniform float iTime;

uniform sampler2D tex;

const float scale = 10.;
#define NUMBER_OF_SAMPLES 2.

vec2 n22(vec2 p){
    vec3 a = fract(p.xyx*vec3(112.5,224.65,486.354));
    a += dot(a,vec3(a.x+125.44,a.y+54.54,a.z+456.45));
    return fract(vec2(a.x*a.y,a.y*a.z));
}

vec4 texBomb()
{
    vec4 col = vec4(0);
    vec2 UV = vUv;
    vec2 scaledUV = UV * scale;
    vec2 cell = floor(scaledUV);
    vec2 offset = scaledUV - cell;

    // vec2 randomUV = cell * vec2(0.037, 0.119);
    // vec4 random = texture2D(tex, randomUV); 
    // vec4 image = texture2D(tex, offset.xy - random.xy);
    // if (image.w > 0.0){
    //     col.xyz = image.xyz;
    // }

    float priority = -1.;

    for (float i = -1.; i <= 0.; i++) {
    for (float j = -1.; j <= 0.; j++) {
            vec2 cell_t = cell + vec2(i, j);
            vec2 offset_t = offset - vec2(i, j);
            vec2 randomUV = cell_t.xy * vec2(0.037, 0.119);
            for (float k = 0.; k < NUMBER_OF_SAMPLES; k++) {
                vec4 random = texture2D(tex, randomUV);
                randomUV += vec2(0.03*k, 0.17*k);
                vec4 image = texture2D(tex, offset_t - random.xy);
                if (random.w > priority && image.w > 0.0){
                    // col.xyz = vec3(offset_t-random.xy,0);
                    col.xyz = image.xyz;
                    priority = random.w;
                }
            } 
        }
    }

    return col;
}

void main() {
    vec2 q = (gl_FragCoord.xy - .5 * iResolution.xy ) / iResolution.y;
    vec3 col = vec3(0);

    vec4 tb = texBomb();
    col = tb.xyz;
    float alpha = tb.w;

    // gl_FragColor = vec4(col, alpha);
    gl_FragColor = vec4(1,0,0,1);
}