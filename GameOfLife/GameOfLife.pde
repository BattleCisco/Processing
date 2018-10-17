import java.util.ArrayList;
import java.text.DecimalFormat;

Board board;
float cellSize = 6;

int frame = 0;
int framesPerUpdate = 40;
int baseFramePerUpdate = int(framesPerUpdate);

float fillPercentage = 0.2;
float chanceOfMutation = 0.05;

int widthOffset = 240;
int newWidth;

int deadCells = 0;

boolean increaseSpeedButtonWaitForRelease = false;
boolean decreaseSpeedButtonWaitForRelease = false;
boolean pauseButtonWaitForRelease = false;

boolean paused = false;

void setup() {
	size(1200, 900);
	frameRate(144);
	newWidth = width - widthOffset;
	board = new Board(cellSize);

	board.killAllCells();
	board.spawnGliderGun(0, 0, 1, 1);
	board.spawnGliderGun(0, board.getNumberOfRows() - 1, 1, -1);
	board.prepareAnimations();
}

void draw() {
	background(0);
	fill(170, 170, 120);
	rect(0,0, widthOffset, height);
	drawStats();
	if(!paused)
		if(frame % (framesPerUpdate + 1) == 0 && frame != 0) {
			for(Cell cell : board.getChangedCells()) {
				if(!cell.alive)
					deadCells++;
			}

			board.update();
			if((baseFramePerUpdate - framesPerUpdate) != 39)
			{
				board.prepareAnimations();
			}
			else{
				if(board.animations.size() > 0)
					board.animations.clear();
			}
		}
	board.draw();
	if(!paused)
		frame++;
}

void drawStats() {
	textSize(30);
	fill(0);
	
	text("Generation:", 5, 35);
	text(board.generation, 5, 70);

	Board testingStabilityBoard = new Board(board);
	testingStabilityBoard.update();
	testingStabilityBoard.update();
	
	text("Alive:" , 5, 105);
	text(board.getAliveCells().size(), 5, 140);

	text("Dead:" , 5, 175);
	text(deadCells, 5, 210);
	
	DecimalFormat df = new DecimalFormat();
	df.setMaximumFractionDigits(4);
	text("Speed: ", 5, 245);
	text(df.format(1f / (float(framesPerUpdate) / float(baseFramePerUpdate))), 5, 280);

	text("Space: Pauses", 5, height - 305);
	text("the simulation", 5, height - 270);

	text("N: Remove all", 5, height - 225);
	text("living cells", 5, height - 190);
	

	text("P: Output", 5, height - 145);
	text("blueprint", 5, height - 110);

	if(testingStabilityBoard.equals(board)) {
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
	board.mousePressed();
}

void keyPressed() {
	if(keyCode == RIGHT && !increaseSpeedButtonWaitForRelease)
	{
		increaseSpeedButtonWaitForRelease = true;
		if(framesPerUpdate > 1)
			framesPerUpdate--;
	}
	else if(keyCode == LEFT && !decreaseSpeedButtonWaitForRelease)
	{
		decreaseSpeedButtonWaitForRelease = true;
		framesPerUpdate++;
	}
	else if(keyCode == 32 && !pauseButtonWaitForRelease)
	{
		pauseButtonWaitForRelease = true;
		if(paused)
			paused = false;
		else
			paused = true;

	}
	else if(keyCode == 78)
	{
		board.killAllCells();
	}
	else if(keyCode == 80)
	{
		println("public void newSpawnFunction(int x, int y) {");
		for (Cell cell : board.getAliveCells()) {
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