

            precision highp float;
            
            varying vec3 vNormal;
            varying vec3 vWorldNormal;
            varying vec2 vUv;
            varying vec3 vColor;
            varying vec3 vPos;

            #include <skinning_pars_vertex>

            uniform int         uRenderMode;
            uniform vec2        uResolution;
            uniform bool        uInvertUV_Y;
            uniform bool        uDisplayUVLayout;

            #define rm_outline_backface    3

            void main() 
            {
                vNormal = normal;
                
                vUv = (uInvertUV_Y) ? vec2(uv.x, 1.0 - uv.y) : uv; 
                vColor = color;

                #include <skinbase_vertex>
                #include <begin_vertex>
                #include <skinning_vertex>
                
                vPos =  (modelViewMatrix * vec4( transformed, 1.0 )).xyz;
                vWorldNormal = normalize(mat3(modelViewMatrix) * normal);

                gl_Position = projectionMatrix * modelViewMatrix * vec4( transformed, 1.0 );

                if(uDisplayUVLayout)
                {
                    vec2 lUvOut = fract(vUv.xy) * vec2(1.0, uResolution.x / uResolution.y);
                    lUvOut = (!uInvertUV_Y) ? vec2(lUvOut.x, 1.0 - lUvOut.y) : lUvOut;
                    gl_Position = vec4((lUvOut - vec2(1.0, (uInvertUV_Y) ? 1.0 : 0.0))  * 5.0, 1.0, 5.0);
                }
                else if(uRenderMode == rm_outline_backface)
                {
                    gl_Position = vec4(0., 0.,  0., 0.);
                }
            }