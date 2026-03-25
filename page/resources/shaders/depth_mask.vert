#version 100

// Input từ Raylib (Tọa độ gốc của hàm DrawTexturePro)
attribute vec3 vertexPosition; 
attribute vec2 vertexTexCoord;
attribute vec4 vertexColor;

// Output truyền xuống Fragment Shader
varying vec2 fragTexCoord;
varying vec4 fragColor;
varying vec2 fragWorldPos; // <--- VŨ KHÍ BÍ MẬT: Tọa độ thế giới của Pixel!

uniform mat4 mvp; // Ma trận camera của Raylib

void main() {
    fragTexCoord = vertexTexCoord;
    fragColor = vertexColor;
    
    // Bắt lấy tọa độ thế giới (World X, Y) của từng đỉnh
    fragWorldPos = vertexPosition.xy; 
    
    // Tính toán vị trí hiển thị lên màn hình (Mặc định của Raylib)
    gl_Position = mvp * vec4(vertexPosition, 1.0);
}
