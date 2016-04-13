//Noise Wave by Daniel Schiffman https://processing.org/examples/noisewave.html
console.log(document.documentElement.clientWidth, document.documentElement.clientHeight);

float yoff = 0.0;        // 2nd dimension of perlin noise

void setup() {
  size(document.documentElement.clientWidth, document.documentElement.clientHeight);
}

void draw() {
  background(255);

  fill(0);
  // We are going to draw a polygon out of the wave points
  beginShape();
  float xoff = 0;       // Option #1: 2D Noise

  // Iterate over horizontal pixels
  for (float x = 0; x <= width; x += 10) {
    // Calculate a y value according to noise, map to
    float y = map(noise(xoff, yoff), 0, 1, document.documentElement.clientHeight*.3, document.documentElement.clientHeight*.6); // Option #1: 2D Noise

    // Set the vertex
    vertex(x, y);
    // Increment x dimension for noise
    xoff += 0.05;
  }
  // increment y dimension for noise
  yoff += 0.01;
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}
