
            varying vec3 vNormal;
            varying vec2 vUv;
            varying vec3 vColor;

            #include <skinning_pars_vertex>

            uniform float       uThickness;
            uniform float       uZOffset;
            uniform float       uVariation;
            uniform bool        uInvertUV_Y;

            vec2 hash( vec2 p ) 
            { // rand in [-1,1]
                p = vec2( dot(p,vec2(127.1,311.7)),
                          dot(p,vec2(269.5,183.3)) );
                return -1. + 2.*fract(sin(p+20.)*53758.5453123);
            }

            void main() {

                vNormal = normal;
                vUv = (uInvertUV_Y) ? vec2(uv.x, 1.0 - uv.y) : uv;
                vColor = color;

                #include <skinbase_vertex>
                //#include <begin_vertex>
                vec2 variation = min(hash(position.xy * position.yz) * 0.5 + 0.5, 1.5);
                vec3 transformed  = position + uThickness * mix(1.0, variation.x, uVariation) * normal ;
                #include <skinning_vertex>

                
                gl_Position = projectionMatrix * modelViewMatrix * vec4( transformed, 1.0 );

                //Apply z-offset
                //gl_Position.z += 0.00002;
                gl_Position.z += uZOffset;
            }
