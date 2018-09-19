// 1. Skapa en boll, ge den "gravitation"
//   och få den att studsa när den nuddar "marken"
  
//   vx += ax * dt;
//   x += vx * dt;
  
// 2. Skapa en boll som rör sig i en rörelse där
//   den rör sig dubbelt så snabbt i x-led som i y-led
  
//   cos, sin
  
// 3. Skapa en boll, få den att röra sig med hastighet i en
//   vinkel, gör så att den kan svänga höger och vänster
  
//   velocity += acceleration * dt;
//   x += cos(radians(angle)) * velocity * dt;
  
// 4. Gör en boll, få den att "lerpa" mot där användaren
//   trycker med musen
  
//   x = lerp(x, tx, 0.1);
  
// 5*. Gör ett simpelt plattformsspel

// 6*. Gör ett simpelt "bilspel" där en ser bilen ovanifrån

float posX = 200;
float posY = 200;

float velocity = 5;
float direction = 0;

int fr = 60; //frameRate
float frameTime = 1.0 / (float) fr;
float tpf = 0;

float frame = 0;

void setup() {
	size(640, 480);
	strokeWeight(1.5);
	frameRate(fr);
}

void draw() {
	long currentTime = millis();
	main_draw();
	tpf = (millis() - currentTime) * 0.001f;
	//println("tpf: "+tpf);
}

void main_draw() {
	background(0);

	direction = direction % 360 + 3;
	posY += sin(radians(direction)) * velocity;
	posX += cos(radians(direction)) * velocity;

	ellipse(posX, posY, 10, 10);
    frame++;
}

//Autopilot som svänger 3 grader (ÅT HÖGER) varje cykel.