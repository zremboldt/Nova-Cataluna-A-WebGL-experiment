uniform sampler2D tDiffuse;
uniform float scrollSpeed;
varying vec2 vUv;

void main() {
  vec2 newUv = vUv;

  float area = smoothstep(0.4, -0.5, vUv.y);
  newUv.x -= (vUv.x - 0.5)*0.8 * area * scrollSpeed*3.;
  
  gl_FragColor = texture2D(tDiffuse, newUv);
  // gl_FragColor = vec4(newUv.x, 0.0, 0.0, 1.0);
}