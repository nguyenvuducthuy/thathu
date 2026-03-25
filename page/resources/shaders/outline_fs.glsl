
            varying vec3 vNormal;
            varying vec2 vUv;
            varying vec3 vColor;

            uniform sampler2D uBaseColor;
            uniform sampler2D uSSS;

            void main() {
                vec4 base     = texture2D( uBaseColor, vUv );
                vec4 sss     = texture2D( uSSS, vUv );
                gl_FragColor = vec4(base.rgb * sss.rgb * 0.25, 0.0);

            }
