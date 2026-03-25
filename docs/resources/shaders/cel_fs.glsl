
            precision highp float;

            varying vec3 vNormal;
            varying vec3 vWorldNormal;
            varying vec2 vUv;
            varying vec3 vColor;
            varying vec3 vPos;

            uniform mat4 modelViewMatrix;

            uniform sampler2D uBaseColor;
            uniform sampler2D uDecal;
            uniform sampler2D uILM;
            uniform sampler2D uSSS;
            uniform vec2      uResolution;
            uniform int       uRenderMode;
            uniform float     uLightRot;

            #define rm_ggxrd_shading    0
            #define rm_cel_shading      1
            #define rm_outline          2
            #define rm_outline_backface 3
            #define rm_color            4
            #define rm_sss              5
            #define rm_ilm              6
            #define rm_ilm_red          7
            #define rm_ilm_green        8
            #define rm_ilm_blue         9
            #define rm_ilm_alpha        10
            #define rm_vertex_color     11
            #define rm_uvs              12

            void main() 
            {
                vec2 st = gl_FragCoord.xy / uResolution.xy;
                
                //create omnidirectional light direction from the rotation property
                float lightRad = (0.125 + uLightRot) * 3.1416 * 2.0;
                vec2 lightPos = vec2(cos(lightRad), sin(lightRad));
                vec3 lightDir = normalize(vec3( lightPos.x * 30.0, 6.0, lightPos.y * 30.0) );

                float lightValue = (dot( vWorldNormal, lightDir ) + 1.0) * 0.5;
                lightValue = clamp(lightValue, 0.0, 1.0);

                vec4 base    = texture2D( uBaseColor, vUv );
                vec4 decal   = texture2D( uDecal, vUv );
                vec4 ilm     = texture2D( uILM, vUv );
                vec4 sss     = texture2D( uSSS, vUv );

                float threshold = 0.5;

                //shadow bias
                threshold = 1.0 - (ilm.g * vColor.r);

                //base color
                vec3 baseColor = base.rgb;

                //sadow color
                vec3 shadowColor = baseColor * sss.rgb;

                //cel shading
                vec3 celShadingColor = (lightValue > threshold) ? baseColor  : shadowColor;

                //specular & darken areas
                vec3 specularDarkenColor = mix( ilm.rrr, celShadingColor, 0.5);

                //self shadow threshold check
                vec3 finalColor = ((1.0 - lightValue) < ilm.b) ? specularDarkenColor : celShadingColor;
                
                //internal outline
                //finalColor *= ilm.a;

                //finalColor = celShadingColor;

                float outline = (ilm.a < 0.9) ? 0.0 : 1.0;
                gl_FragColor = vec4(finalColor * outline, outline);

                if(uRenderMode == rm_cel_shading)
                {
                    gl_FragColor = vec4((lightValue < 0.5) ? baseColor * 0.4 : baseColor, 1.0);
                }
                else if(uRenderMode == rm_outline)
                {
                    gl_FragColor = vec4(0.9, 0.9, 0.9, 1.0);
                }
                else if(uRenderMode == rm_outline_backface)
                {
                    gl_FragColor = vec4(0.9, 0.9, 0.9, 0.0);
                }
                else if(uRenderMode == rm_color)
                {
                    gl_FragColor = vec4(baseColor, 1.0);
                }
                else if(uRenderMode == rm_sss)
                {
                    gl_FragColor = vec4(sss.rgb, 1.0);
                }
                else if(uRenderMode == rm_ilm)
                {
                    gl_FragColor = vec4(ilm.rgb, 1.0);
                }
                else if(uRenderMode == rm_ilm_red)
                {
                    gl_FragColor = vec4(ilm.rrr, 1.0);
                }
                else if(uRenderMode == rm_ilm_green)
                {
                    gl_FragColor = vec4(ilm.ggg, 1.0);
                }
                else if(uRenderMode == rm_ilm_blue)
                {
                    gl_FragColor = vec4(ilm.bbb, 1.0);
                }
                else if(uRenderMode == rm_ilm_alpha)
                {
                    gl_FragColor = vec4(ilm.aaa, 1.0);
                }
                else if(uRenderMode == rm_vertex_color)
                {
                    gl_FragColor = vec4(vColor, 1.0);
                }
                else if(uRenderMode == rm_uvs)
                {
                    gl_FragColor = vec4(vec3(vUv.xy, 0.5), 1.0);
                }
            }
