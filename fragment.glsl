varying vec3 normal;
varying vec4 world_position;

void main()
{
    vec4 ambient = vec4(0, 0, 0, 1);
    vec4 diffuse = vec4(0, 0, 0, 1);
    vec4 specular = vec4(0, 0, 0, 1);
    
    vec3 l;
    vec3 r;
    vec3 n = normal;
    
    
    //So piazza says there is suppose to be only 1 light but I got 8 I think
    //But if we do (gl_MaxLights - 3) we get the solution. idk why
    //MODIFIED so it looks more like the solution picture but
    //This shouldn't be the correct solution... check with TA
//    for(int i = 0; i < gl_MaxLights - 3; i++){
    	
    	//light intersection
    	l = normalize(gl_LightSource[0].position.xyz - world_position.xyz);
    	
    	
    	//reflection vector
    	r = -l + (2.0 * dot(l, n) * n);
    	
    	ambient +=
    	//ambient = 
    				//gl_LightSource[0].ambient	//doesnt work? see piazza
    				gl_LightModel.ambient
    				* gl_FrontMaterial.ambient;
    	
    	//diffuse += 							//see piazza, only 1 light?
    	diffuse = 
    				gl_LightSource[0].diffuse	//There's only 1 light
    				//gl_LightModel.diffuse
    				* gl_FrontMaterial.diffuse 
    				* max(dot(normalize(n), l), 0.0);
    	
    	//specular += 							//see piazza, only 1 light?
    	specular = 
    				gl_LightSource[0].specular 	//There's only 1 light
    				//gl_LightModel.specular
    				* gl_FrontMaterial.specular 
    				* pow(max(dot(normalize(-world_position.xyz), r), 0.0), gl_FrontMaterial.shininess);
//    }
    
    gl_FragColor = ambient + diffuse + specular;
}
