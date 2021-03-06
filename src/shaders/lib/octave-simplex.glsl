#pragma glslify: simplex = require('glsl-noise/simplex/2d');

const int OCTAVES = 8;
const float PERSISTANCE = .5;

/*
octaveSimplex noise

Superimposes a series of sine waves
which increase in frequency but decrease
in amplitude, the amplitudes also run
through a simplex noise algorithm

Creates fractal like pattern
*/
float octaveSimplex(vec2 vertex, float time) {
  float total = 0.;
  float frequency = 1.;
  float amplitude = 1.;
  float maxValue = 0.;
  vec2 dz = vec2(0., time);
  for (int i = 0; i < OCTAVES; i++) {
    total += amplitude * simplex(frequency * (vertex + dz) / 50.);
    maxValue += amplitude;
    amplitude *= PERSISTANCE;
    frequency *= 2.;
  }
  return total / maxValue;
}

#pragma glslify: export(octaveSimplex);
