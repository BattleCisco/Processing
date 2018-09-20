CharacterManager gm;

void setup() {
	size(640, 480);
	gm = new CharacterManager(100);
	strokeWeight(1.5);
  	stroke(255);
}

void draw() {
	background(0);
	gm.update();
	gm.draw();
}
