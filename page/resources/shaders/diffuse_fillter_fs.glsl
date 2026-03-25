
            varying vec2 vUv;

            uniform sampler2D tDiffuse;
            uniform vec2      uResolution;
            uniform float     uPower;

            vec3 toneMapping(vec3 hdrColor, float exposure, float gamma)
            {
                // Exposure tone mapping
                vec3 mapped = vec3(1.0) - exp(-hdrColor * exposure);
                
                // Gamma correction
                mapped = pow(abs(mapped), vec3(1.0 / gamma));
                
                return mapped;
            }

            float normpdf(in float x, in float sigma)
            {
                return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
            }

            void main() {
                //vec4 diffuse = texture2D( tDiffuse, vUv );
                //gl_FragColor = vec4(diffuse.rgb * vec3(1.0, 0.5, 0.0), 1.0);

                vec4 sourceColor = texture2D(tDiffuse, vUv);
                vec3 c = texture2D(tDiffuse, vUv).rgb;
                float oultine = sourceColor.a;

                //declare stuff
                const int mSize = 15;
                const int kSize = (mSize-1)/2;
                float kernel[mSize];
                vec3 final_colour = vec3(0.0);
                
                //create the 1-D kernel
                float sigma = 7.0;
                float Z = 0.0;
                for (int j = 0; j <= kSize; ++j)
                {
                    kernel[kSize+j] = kernel[kSize-j] = normpdf(float(j), sigma);
                }
                
                //get the normalization factor (as the gaussian has been clamped)
                for (int j = 0; j < mSize; ++j)
                {
                    Z += kernel[j];
                }
                
                //read out the texels
                for (int i=-kSize; i <= kSize; ++i)
                {
                    for (int j=-kSize; j <= kSize; ++j)
                    {
                        vec2 texCoord =  vUv + (vec2(float(i),float(j)) / uResolution.xy);
                        final_colour += kernel[kSize+j]*
                                        kernel[kSize+i]*
                                        texture2D(tDiffuse, texCoord).rgb;
            
                    }
                }
                final_colour = max(c, final_colour/(Z*Z));
                //diffuse filter has less effect in the outline (outline and ilm.a)
                float outlineAttenuation = mix(uPower * 0.55, uPower, oultine);

                final_colour = mix(c, final_colour, outlineAttenuation);
                final_colour = toneMapping(final_colour, 3.0, 0.32);
                gl_FragColor = vec4(final_colour, 1.0);
            }
