CharacterManager gm;

void setup() {
	size(640, 480);
	gm = new CharacterManager(25);
	strokeWeight(1.5);
  	stroke(255);
}

void draw() {
	background(0);
	gm.update();
	gm.draw();
	//float def=100;
	//strokeWeight(1.5);
	//line(def, 0, def, def);
	//line(0, def, def, def);
	//draw_zombie(new FloatVector(def/2, def/2), 0, def/100, color(0, 255, 0));
	//draw_human(new FloatVector(def/2, def/2), 0, def/100, color(234, 180, 63));
	if(gm.isGameOver())
	{
		textSize(110);
		fill(0, 0, 255);
		text("Game over!", 10, 99);
	}

}
