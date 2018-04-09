precision mediump float;

uniform vec3                iResolution;
uniform float               iGlobalTime;
uniform sampler2D           iChannel0;
varying vec2                texCoord;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy;
    vec3 tex = texture2D( iChannel0, uv ).rgb;

    float x =(uv.x*iResolution.x);
    float y =(uv.y*iResolution.y);

    vec3 col;

    float h = 0.0;
    float maxi = max(max(tex.x,tex.y),tex.z);
    float mini = min(min(tex.x,tex.y),tex.z);
    float del = maxi-mini;
    float lum = (maxi+mini)/2.0;
    float sat = del/(1.0-abs(2.0*lum - 1.0));

    if(del==0.0){
        h = 0.0;
    }
    else if (maxi == tex.x){
        h = (tex.y - tex.z)/del;
    } else if (maxi == tex.y){
        h = (tex.z - tex.x)/del + 2.0;
    } else if (maxi == tex.z){
        h = (tex.x - tex.y)/del + 4.0;
    }

    h = h*60.0;

    if(h < 0.0){
        h = h + 360.0;
    }

if(lum > .22 && sat>.27){
    if((h>335.0||h<15.0)&&x/20.0-floor(x/20.0)>.5){
        col = .5*tex;
    }
    else if((h>85.0&&h<165.0)&&y/20.0-floor(y/20.0)>.5){
        col = .5*tex;
    }
    else col = tex;
    }
    else col = tex;


    fragColor = vec4(col,1.0);
}

void main() {
	mainImage(gl_FragColor, texCoord);
}