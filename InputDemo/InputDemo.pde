PVector position;
float speed = 5;

void setup() {
	size(1024, 1024);
	position = new PVector(width / 2, height / 2);
	ellipseMode(CENTER);
}

void draw() {

	float x = getAxisRaw("Horizontal") * speed;
	float y = getAxisRaw("Vertical") * speed;
	position.x += x;
	position.y += y;
	

	background(0);
	ellipse(position.x, position.y, 30, 30);
}