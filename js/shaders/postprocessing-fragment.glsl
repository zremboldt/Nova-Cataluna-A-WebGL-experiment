uniform sampler2D tDiffuse;
uniform float scrollSpeed;
varying vec2 vUv;

float map(float value, float inMin, float inMax, float outMin, float outMax) {
  return outMin + (outMax - outMin) * (value - inMin) / (inMax - inMin);
}

void main() {
  vec2 uv = vUv;

  vec4 myTexture = texture2D(tDiffuse, uv);

  float curveLevel = min(1., scrollSpeed * .6);
  float nUvY = pow(1. - uv.y * 1., 10.) * curveLevel;

  float curve = max(0., nUvY) + 1.;
  curve = map(curve, 1., 5., 1., 2.);
  uv.x = uv.x / curve + ((curve - 1.) / 2. / curve);

  //Curve generation
  myTexture = texture2D(tDiffuse, clamp(uv, vec2(0.), vec2(1.)));

  //Pixel displace
  uv.y += myTexture.r * nUvY * .7;
  if(uv.y < 1.)
    myTexture = texture2D(tDiffuse, uv);

  // RGB shift
  uv.y += 0.15 * nUvY;
  if(uv.y < 1.)
    myTexture.g = texture2D(tDiffuse, uv).g;

  uv.y += 0.10 * nUvY;
  if(uv.y < 1.)
    myTexture.b = texture2D(tDiffuse, uv).b;

  gl_FragColor = myTexture;

  // Use this line to debug values
  // gl_FragColor = vec4(nUvY, 0.0, 0.0, 1.0);
}