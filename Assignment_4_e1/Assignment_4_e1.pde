int frame = 0;

PFont f;

PVector random_vector = new PVector((int) random(0, width), (int) random(0, height));

void setup() {
	size(640, 480);
	strokeWeight(1.5);
	stroke(255);
	f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
	textFont(f, 36);
	background(120);
	text("Draw (" + String.valueOf(random_vector.x) + ", " + String.valueOf(random_vector.y) + ")", 10, 46);


}

void draw() {
	int a = 5;
	a++;
}

void mousePressed() {
	background(220);
	stroke(180);
	line(0, 0, mouseX, mouseY);
	stroke(255);
	PVector drawn_vector = new PVector(mouseX, mouseY);
	PVector difference = drawn_vector.sub(random_vector);
	text("You drew (" + mouseX + ", " + mouseY + "), which was " + (int) difference.mag() + "p close.", 10, 46);

} 