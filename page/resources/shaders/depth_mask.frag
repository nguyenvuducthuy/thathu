#version 100

// BẮT BUỘC TRONG WEBGL: Khai báo độ chính xác của số thực
precision mediump float; 

// Dùng 'varying' thay vì 'in' để nhận dữ liệu từ Vertex
varying vec2 fragTexCoord;
varying vec4 fragColor;
varying vec2 fragWorldPos;

uniform sampler2D texture0;
uniform sampler2D depthMap;

uniform vec2 mapSize;
// uniform vec2 mapTopLeft;
uniform float playerDepth;

void main() {
  // Dùng texture2D thay vì texture
  vec4 charColor = texture2D(texture0, fragTexCoord);

  // Tính Static UV như cũ
  vec2 staticMapUV  = (fragWorldPos) / mapSize;
  staticMapUV      += .5;

  // Đọc độ sâu (texture2D)
  vec4 env_color          = texture2D(depthMap, staticMapUV);
  float environmentDepth  = env_color.r;
  float environmentShadow = env_color.g;

  // Kiểm tra che khuất
  if (playerDepth < environmentDepth && charColor.a > 0.0) {
    discard;
  }

  if (charColor.a < 0.1) discard;

  // Gán thẳng vào biến hệ thống gl_FragColor thay vì tạo biến out
  vec3 color = charColor.xyz * fragColor.xyz * mix(0.5,1.,environmentShadow);
  float a    = charColor.a;
  gl_FragColor = vec4(color,a);
  // gl_FragColor = vec4(environmentDepth,0,0,1);
}
