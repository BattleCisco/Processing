import java.util.ArrayList;
import java.text.DecimalFormat;


Board board;
float cellSize = 20;

int frame = 0;
int framesPerUpdate = 40;
int baseFramePerUpdate = int(framesPerUpdate);

float fillPercentage = 0.2;
float chanceOfMutation = 0.2;

int width_offset = 300;
int new_width;

boolean increase_speed_button_hold = false;
boolean decrease_speed_button_hold = false;

void setup() {
	size(1200, 900);
	frameRate(144);
	new_width = width - width_offset;
	board = new Board(cellSize);
}

void draw() {
	background(0);
	fill(170, 170, 120);
	rect(0,0, width_offset, height);
	drawStats();
	if(frame % (framesPerUpdate + 1) == 0 && frame != 0){
		board.update();
		board.prepareAnimations();
	}
	board.draw();
	frame++;
}

void drawStats()
{
	textSize(30);
	fill(0);
	text("Generation: " + board.generation, 5, 35);

	Board testingStabilityBoard = new Board(board);
	testingStabilityBoard.update();
	testingStabilityBoard.update();
	
	DecimalFormat df = new DecimalFormat();
	df.setMaximumFractionDigits(5);
	text("Speed: " + df.format(1f / (float(framesPerUpdate) / float(baseFramePerUpdate))), 5, 70);

	if(testingStabilityBoard.equals(board))
	{
		fill(0, 200, 0);
		text("Stable", 5, 105);
	}
	else {
		fill(200, 0, 0);
		text("Unstable", 5, 105);
	}
}

void mousePressed() {
	board.mousePressed();
}

void keyPressed() {
	if(keyCode == RIGHT && !increase_speed_button_hold)
	{
		increase_speed_button_hold = true;
		if(framesPerUpdate > 1)
			framesPerUpdate--;
	}
	else if(keyCode == LEFT && !decrease_speed_button_hold)
	{
		decrease_speed_button_hold = true;
		framesPerUpdate++;
	}
}

void keyReleased() {
	if(keyCode == RIGHT && increase_speed_button_hold)
	{
		increase_speed_button_hold = false;
	}
	else if(keyCode == LEFT && decrease_speed_button_hold)
	{
		decrease_speed_button_hold = false;
	}
}