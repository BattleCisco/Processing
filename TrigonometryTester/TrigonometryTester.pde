float direction = 0;

void setup() {
	size(640, 480);
	stroke(255);
}

void draw() {
	background(0);
	direction += 0.5;

	stroke(255);
	int def=100;
	strokeWeight(1.5);
	line(def, 0, def, def);
	line(0, def, def, def);
	stroke(0, 0, 255);
	line(def/2, def/2, def/2 + cos(radians(direction)) * def/2, def/2 + sin(radians(direction)) * def/2);
}

void draw_angle(float direction)
{
	stroke(255);
	int def=100;
	strokeWeight(1.5);
	line(def, 0, def, def);
	line(0, def, def, def);
	stroke(0, 0, 255);
	line(def/2, def/2, def/2 + cos(radians(direction)) * def/2, def/2 + sin(radians(direction)) * def/2);
}