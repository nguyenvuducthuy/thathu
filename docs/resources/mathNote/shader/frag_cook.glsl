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


void main(void){ 
  vec2 uv    = v_uv;
  // 1. Thu nhỏ UV gốc xuống 1/4 (vì lưới 4x4)
  uv *= 0.25;

  // 2. Dịch chuyển đến đúng ô nguyên liệu
  // u_offset sẽ là vec2(col * 0.25, row * 0.25)
  // Lưu ý: Nếu texture bị ngược chiều Y, bạn có thể cần: 
  // vec2 finalUV = spriteUV + vec2(u_offset.x, 0.75 - u_offset.y);
  // uv += u_offset;
  // uv += vec2(u_offset.x, .75-u_offset.y);
  uv += vec2(u_offset.x,3.-u_offset.y)*.25;

  vec4 out_c   = texture(uMainTex, uv);
  // out_c = vec4(finalUV,0,1);

  finalColor   = out_c;
}

