uniform float time;
uniform vec2 hover;
uniform float hoverState;
varying float vNoise;
varying vec2 vUv;

void main() {
  vec3 newPos = position;

  float dist = distance(uv, hover);

  newPos.z += hoverState*10. * sin(dist * 10. - time);

  // These two lines below aren't used here but are sent to the fragment shader.
  vNoise = hoverState * sin(dist * 10. - time);
  vUv = uv;

  gl_Position = projectionMatrix * modelViewMatrix * vec4( newPos, 1.0 );
}
