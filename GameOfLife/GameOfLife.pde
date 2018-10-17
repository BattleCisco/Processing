import java.util.ArrayList;
import java.text.DecimalFormat;

Simulation simulation;
float cellSize = 6;

int frame = 0;
int framesPerUpdate = 41;
int baseFramePerUpdate = int(framesPerUpdate - 1);

float fillPercentage = 0.2;
float chanceOfMutation = 0.05;

int widthOffset = 318;
int newWidth;

//Processing's key input will send more than one event, this is to prevent it from repetedly triggering.
boolean increaseSpeedButtonWaitForRelease = false;
boolean decreaseSpeedButtonWaitForRelease = false;
boolean pauseButtonWaitForRelease = false;

boolean paused = false;

void setup() {
	size(1200, 900);
	frameRate(144);
	newWidth = width - widthOffset;
	simulation = new Simulation(cellSize);

	simulation.killAllCells();
	simulation.spawnGliderGun(0, 0, 1, 1);
	simulation.spawnGliderGun(0, simulation.getNumberOfRows() - 1, 1, -1);
	simulation.prepareAnimations();
}

void draw() {
	background(0);
	fill(170, 170, 120);
	rect(0,0, widthOffset, height);
	drawStats();
	if(!paused)
		if(frame % (framesPerUpdate + 1) == 0 && frame != 0) {
			simulation.step();
			if((framesPerUpdate) != 0)
			{
				simulation.prepareAnimations();
			}
			else{
				if(simulation.animations.size() > 0)
					simulation.animations.clear();
			}
		}
	
	simulation.draw();
	if(!paused)
		frame++;
}

void drawStats() {
	textSize(30);
	fill(0);
	Simulation stabilityTest = new Simulation(simulation);
	stabilityTest.step();
	stabilityTest.step();
	
	text("Generation:", 5, 35);
	text(simulation.generation, 5, 70);

	text("Alive:" , 5, 105);
	text(simulation.getAliveCells().size(), 5, 140);

	text("Dead:" , 5, 175);
	text(simulation.deadCells, 5, 210);
	
	DecimalFormat df = new DecimalFormat();
	df.setMaximumFractionDigits(4);
	text("Speed: ", 5, 245);
	text(df.format(1f / (float(framesPerUpdate + 1) / float(baseFramePerUpdate))), 5, 280);

	text("G: Spawn glider gun", 5, height - 525);
	text("A: Spawn acorn", 5, height - 490);

	text("L-Click: Spawn cell", 5, height - 455);
	text("R-Click: Kill cell", 5, height - 420);

	text("Left: Decrease speed", 5, height - 385);
	text("Right: Increase speed", 5, height - 350);
	
	text("Space: Pauses", 5, height - 305);
	text("the simulation", 5, height - 270);

	text("N: Remove all", 5, height - 225);
	text("living cells", 5, height - 190);
	
	text("P: Output", 5, height - 145);
	text("blueprint", 5, height - 110);

	if(stabilityTest.equals(simulation)) {
		fill(0, 145, 0);
		text("Stable", 5, height - 40);
	}
	else {
		fill(120, 0, 0);
		text("Unstable", 5, height - 40);
	}

	if(paused) {
		fill(120, 0, 0);
		text("Paused", 5, height - 5);
	}
	else {
		fill(0, 145, 0);
		text("Playing", 5, height - 5);
	}
}

void mousePressed() {
	simulation.mousePressed();
}

void keyPressed() {
	println(keyCode);
	if(keyCode == RIGHT && !increaseSpeedButtonWaitForRelease) {
		increaseSpeedButtonWaitForRelease = true;
		if(framesPerUpdate >= 1)
			framesPerUpdate--;
	}
	else if(keyCode == LEFT && !decreaseSpeedButtonWaitForRelease) {
		decreaseSpeedButtonWaitForRelease = true;
		framesPerUpdate++;
	}
	else if(keyCode == 32 && !pauseButtonWaitForRelease) {
		pauseButtonWaitForRelease = true;
		if(paused)
			paused = false;
		else
			paused = true;
	}
	else if (keyCode == 65) {//A - Acorn
		int x = int((mouseX - widthOffset) / cellSize);
		int y = int(mouseY / cellSize);

		simulation.spawnAcorn(x, y);
	}
	else if (keyCode == 71) {//G - Glider gun
		int x = int((mouseX - widthOffset) / cellSize);
		int y = int(mouseY / cellSize);

		simulation.spawnGliderGun(x, y, 1, 1);
	}
	else if(keyCode == 78) {//N - Nuke
		simulation.killAllCells();
	}
	else if(keyCode == 80) {//P - Print
		println("public void newSpawnFunction(int x, int y) {");
		for (Cell cell : simulation.getAliveCells()) {
			println("\tthis.setCellAlive(x + " + cell.x, ", y + " + cell.y + ");");
		}
		println("}");
	}
}

void keyReleased() {
	if(keyCode == RIGHT && increaseSpeedButtonWaitForRelease)
	{
		increaseSpeedButtonWaitForRelease = false;
	}
	else if(keyCode == LEFT && decreaseSpeedButtonWaitForRelease)
	{
		decreaseSpeedButtonWaitForRelease = false;
	}
	else if(keyCode == 32 && pauseButtonWaitForRelease)
	{
		pauseButtonWaitForRelease = false;
	}
}