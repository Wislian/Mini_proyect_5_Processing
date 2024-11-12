float x, y;           // Posición actual del objeto
float targetX, targetY; // Posición objetivo (posición del ratón)
float easing = 0.05;   // Factor de amortiguación para el retardo
float waveAmplitude = 30; // Amplitud de la onda
float waveFrequency = 0.1; // Frecuencia de la onda

void setup() {
  size(800, 600);
  x = width / 2;
  y = height / 2;
}



//onda ondulatoria
void draw() {
  background(255);

  // Posición objetivo (ratón)
  targetX = mouseX;
  targetY = mouseY;

  // Interpolación para movimiento suave hacia el cursor
  x += (targetX - x) * easing;
  y += (targetY - y) * easing;

  // Aplicar movimiento curvilíneo (ondas)
  float offsetY = sin(frameCount * waveFrequency) * waveAmplitude;
  
  // Dibujamos el objeto con la oscilación en la coordenada Y
  fill(0);
  noStroke();
  ellipse(x, y + offsetY, 20, 20);  // `y + offsetY` para la oscilación
}


// onda cuadrada
/*void draw() {
  background(255);

  // Posición objetivo (ratón)
  targetX = mouseX;
  targetY = mouseY;

  // Movimiento suave hacia el cursor
  x += (targetX - x) * easing;
  y += (targetY - y) * easing;

  // Movimiento en onda cuadrada
  float offsetY = (frameCount * waveFrequency % 1 < 0.5 ? 1 : -1) * waveAmplitude;

  // Dibujamos el objeto
  fill(0);
  noStroke();
  ellipse(x, y + offsetY, 20, 20);
}

//Onda triangular
void draw() {
  background(255);

  // Posición objetivo (ratón)
  targetX = mouseX;
  targetY = mouseY;

  // Movimiento suave hacia el cursor
  x += (targetX - x) * easing;
  y += (targetY - y) * easing;

  // Movimiento en onda triangular
  float t = frameCount * waveFrequency % 1;
  float offsetY = (t < 0.5 ? t * 2 : (1 - t) * 2) * waveAmplitude * 2 - waveAmplitude;

  // Dibujamos el objeto
  fill(0);
  noStroke();
  ellipse(x, y + offsetY, 20, 20);
}
*/
