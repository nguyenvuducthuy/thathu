varying vec3 vNormal;
varying vec3 vWorldNormal;
varying vec2 vUv;
varying vec3 vColor;
varying vec3 vPos;

uniform mat4 uShadowCameraP;
uniform mat4 uShadowCameraV;

varying vec4 vShadowCoord;
void main() {
    vUv = uv;
    vPos = position;
    vColor = vec3(1);
    vWorldNormal = normalize(mat3(modelViewMatrix) * normal);
    vNormal = normal;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0); 
    vShadowCoord = uShadowCameraP * uShadowCameraV * modelMatrix * vec4(position, 1.0);
}

