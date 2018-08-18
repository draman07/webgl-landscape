precision mediump float;

const vec3 DIFFUSE_LIGHT_COLOR = vec3(.85, .8, .7);
const vec3 AMBIENT_COLOR = vec3(.2, .2, .3);
const vec3 SPECULAR_COLOR = vec3(.8, .8, .7);
const vec3 FOG_COLOR = vec3(.75, .87, .9);

uniform vec3 u_CameraPosition;
uniform vec3 u_LightPosition;

varying vec3 v_PlaneVertex;
varying vec3 v_PlaneNormal;
varying float v_Time;

#pragma glslify: fragColor = require('../../lib/frag-color.glsl');
#pragma glslify: fog = require('../../lib/fog.glsl');

void main() {
  vec3 lightDirection = normalize(u_LightPosition - v_PlaneVertex);
  vec3 viewDirection = normalize(u_CameraPosition - v_PlaneVertex);
  vec3 halfwayVector = normalize(lightDirection + viewDirection);

  float lambertian = clamp(dot(lightDirection, v_PlaneNormal), 0., 1.);
  if (lambertian > .7) {
    lambertian = .8;
  } else if (lambertian > .5) {
    lambertian = .6;
  } else if (lambertian < .3) {
    lambertian = 0.;
  }
  float specular = clamp(dot(halfwayVector, v_PlaneNormal), 0., 1.);
  specular = pow(specular, 100.);
  specular *= .4;

  vec3 lightColor = AMBIENT_COLOR;
  lightColor += (lambertian * DIFFUSE_LIGHT_COLOR);
  // lightColor += (specular * SPECULAR_COLOR);

  vec3 color = lightColor * fragColor(v_PlaneVertex, v_PlaneNormal, 10., v_Time);

  float fogWeight = fog(u_CameraPosition, v_PlaneVertex);
  color = ((1. - fogWeight) * color) + (fogWeight * FOG_COLOR);

  gl_FragColor = vec4(color, 1.);
}