#version 300 es
precision mediump float;
#define PI 3.14159265359 
in      vec4      color;
in      vec2      v_uv;
in      vec3      v_normal;
uniform sampler2D uMainTex;
uniform float     u_time;
uniform vec2      u_offset;
out     vec4      finalColor;

// https://www.shadertoy.com/view/ldXfz2
vec3 drawArrow(vec2 pixel, vec2 origin, vec2 arrow, float head) {
  vec2 p = pixel - origin;
  vec2 v = normalize(arrow);
  float projection = dot(p, v);
  if (projection < 0.0) {
    return vec3(0);
  }
  vec2 offset = p - projection * v;
  float body = max(0.0, length(arrow) - head);
  float l = length(p);
  float w = 0.0;
  if (l < body) {
    w = .01;
  } else if (l < body + head) {
    w = body + head - l;
  }
  if (length(offset) < w) {
    return vec3(1);
  } else {
    return vec3(0);
  }
}

float drawPoint(vec2 p){
  return step(length((v_uv*2.-1.)-p),.04);
}


vec3 barycentric(vec2 p, vec2 a, vec2 b, vec2 c) {
  vec2 v0 = b - a;
  vec2 v1 = c - a;
  vec2 v2 = p - a;
  float d00 = dot(v0, v0);
  float d01 = dot(v0, v1);
  float d11 = dot(v1, v1);
  float d20 = dot(v2, v0);
  float d21 = dot(v2, v1);
  float denom = d00 * d11 - d01 * d01;
  float v = (d11 * d20 - d01 * d21) / denom;
  float w = (d00 * d21 - d01 * d20) / denom;
  float u = 1.0 - v - w;
  return vec3(u, v, w);
}

float sdParabola( in vec2 pos, in float k ) {
    pos.x = abs(pos.x);
    float ik = 1.0/k;
    float p = ik*(pos.y - 0.5*ik)/3.0;
    float q = 0.25*ik*ik*pos.x;
    float h = q*q - p*p*p;
    float x;
    if( h>0.0 )
    {
        float r = pow(q+sqrt(h),1.0/3.0);
        x = r + p/r;
    }
    else
    {
        float r = sqrt(p);
        x = 2.0*r*cos(acos(q/(p*r))/3.0);
    }
    return length(pos-vec2(x,k*x*x)) * sign(pos.x-x);
}

vec3 color_sdf(float d){
  vec3 col = (d>0.0) ? vec3(0.9,0.6,0.3) : vec3(0.65,0.85,1.0);
	col *= 1.0 - exp2(-8.0*abs(d));
	col *= 0.7 + 0.2*cos(110.0*d);
	col = mix( col, vec3(1.0), 1.0-smoothstep(0.0,0.015,abs(d)) );
  return col;
}

float draw_a_func(vec2 uv){
  float r = .9*abs(sin(u_time*.5));
  // quadratic
  float fx = pow(uv.x, 3.0) - uv.y;
  // circle
  fx = uv.x*uv.x + uv.y*uv.y - r*r;
  return abs(fx);
}

void main(void){ 
  vec2 uv = v_uv;
  uv = uv *2.-1.;
  vec3 out_c = vec3(uv,0);
  // out_c = texture(uMainTex, v_uv).xyz;
  float d = sdParabola(uv, 3.);
  d = draw_a_func(uv);

  out_c = color_sdf(d);
  finalColor = vec4(out_c,1);
}

