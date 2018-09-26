import java.text.DecimalFormat;

CharacterManager gm;

void setup() {
	size(1280, 720);
	gm = new CharacterManager(2);
	strokeWeight(1.5);
  	stroke(255);
}

void draw() {
	background(0);
	gm.update();
	gm.draw();
	if(gm.isGameOver()) {
		if(gm.secondsPassedBeforeGameOver == 0.0) {
			gm.secondsPassedBeforeGameOver = millis() * 0.001f;
		}

		textSize(110);
		fill(0, 0, 255);
		text("Game over!", 10, 99);
		textSize(40);
		DecimalFormat df = new DecimalFormat();
		df.setMaximumFractionDigits(2);
		text("Humans survived for " + df.format(gm.secondsPassedBeforeGameOver) + "s", 47, 155);
	}

}
