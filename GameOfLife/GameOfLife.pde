import java.util.ArrayList;

GameObject cells[][];
float cellSize = 20;
int numberOfColums;
int numberOfRows;

int frame = 0;
int framesPerUpdate = 50;
float fillPercentage = 0.2;
float chanceOfMutation = 0.2;


void setup() {
	size(900, 900);
	frameRate(144);

	numberOfColums = (int) Math.floor(width / cellSize);
	numberOfRows =  (int) Math.floor(height / cellSize);

	stroke(255);
	cells = new GameObject[numberOfColums][numberOfRows];
	for (int y = 0; y < numberOfRows; ++y)
		for (int x = 0; x < numberOfColums; ++x) {
			cells[x][y] = new GameObject(x, y, color(0), false);
			if (random(0, 1) < fillPercentage) {
				cells[x][y].alive = true;
				cells[x][y].cellColor = color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255));
			}
		}

	//spawnAliveCell(1, 0, color(255, 0, 0));
	//spawnAliveCell(1, 1, color(0, 255, 0));
	//spawnAliveCell(1, 2, color(0, 0, 255));
	
	//Acorn spawner
	spawnAcorn(25, 25);
	//spawnAcorn(10, 0);
	//spawnAcorn(0, 10);
	//spawnAcorn(10, 10);
}

void spawnAcorn(int x, int y) {
	spawnAliveCell(x + 3, y + 2, color(255, 0, 0));

	spawnAliveCell(x + 2, y + 4, color(0, 255, 0));
	spawnAliveCell(x + 3, y + 4, color(255, 0, 255));

	spawnAliveCell(x + 5, y + 3, color(0, 255, 0));

	spawnAliveCell(x + 6, y + 4, color(255, 0, 255));
	spawnAliveCell(x + 7, y + 4, color(0, 255, 0));
	spawnAliveCell(x + 8, y + 4, color(255, 255, 0));
}

int getAliveNeighbors(GameObject cell){
	int numberOfAliveNeighbors = 0;
	for (int dx = -1; dx < 2; dx++)
		for (int dy = -1; dy < 2; dy++)
			if(dy != 0 || dx != 0)
				if(cell.x + dx >= 0 && cell.x + dx < numberOfColums)
					if(cell.y + dy >= 0 && cell.y + dy < numberOfRows)
						if(cells[cell.x + dx][cell.y + dy].alive)
							numberOfAliveNeighbors += 1;
	return numberOfAliveNeighbors;
}

ArrayList<GameObject> getChangedCells() {
	ArrayList<GameObject> changedCells = new ArrayList<GameObject>();

	for (int y = 0; y < numberOfRows; ++y)
		for (int x = 0; x < numberOfColums; ++x){
			int numberOfAliveNeighbors = getAliveNeighbors(cells[x][y]);
			
			GameObject possiblyChangedCell;
			//if(numberOfAliveNeighbors > 0)
			// println("Alive neighbors for " + (int) cells[x][y].x 
			// 	+ ", " + (int) cells[x][y].y + ": " + numberOfAliveNeighbors);
			
			if(cells[x][y].alive)
			{
				if(numberOfAliveNeighbors == 2 || numberOfAliveNeighbors == 3)
					possiblyChangedCell = cells[x][y];
				else
					possiblyChangedCell = new GameObject(cells[x][y], cells[x][y].cellColor, false);
			}
			else {
				if(numberOfAliveNeighbors == 3)
				{
					int c;
					if(random(0, 1) < chanceOfMutation){
						c = color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255));
					}
					else {
						c = getResultingColor(x, y);
					}
					possiblyChangedCell = new GameObject(cells[x][y], c, true);
				}
				else
					possiblyChangedCell = cells[x][y];
			}

			if(cells[x][y].alive != possiblyChangedCell.alive)
				changedCells.add(possiblyChangedCell);
		}

	return changedCells;
}



void updateBoard(){
	ArrayList<GameObject> changedCells = getChangedCells();

	for (GameObject cell : changedCells) {
		// if(cell.alive)
		// 	println("Changed " + (int) cell.x 
		// 		+ ", " + (int) cell.y + " to alive.");
		// else
		// 	println("Changed " + (int) cell.x 
		// 		+ ", " + (int) cell.y + " to dead.");
		cells[(int) cell.x][(int) cell.y] = new GameObject(cell); 
	}
}

void spawnAliveCell(int x, int y, color c) {
	cells[x][y] = new GameObject(x, y, color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255)), true);
	cells[x][y].cellColor = c;
}

color getResultingColor(int x, int y) {
	ArrayList<GameObject> aliveCells = new ArrayList<GameObject>();
	for (int dx = -1; dx < 2; dx++)
	for (int dy = -1; dy < 2; dy++)
		if(dy != 0 || dx != 0)
			if(x + dx >= 0 && x + dx < numberOfColums)
				if(y + dy >= 0 && y + dy < numberOfRows)
					if(cells[x + dx][y + dy].alive)
						aliveCells.add(cells[x + dx][y + dy]);

	int redSum=0, greenSum=0, blueSum=0;
	for (GameObject cell : aliveCells) {
		redSum += red(cell.cellColor);
		greenSum += green(cell.cellColor);
		blueSum += blue(cell.cellColor);
	}
	redSum = int(redSum / aliveCells.size());
	greenSum = int(greenSum / aliveCells.size());
	blueSum = int(blueSum / aliveCells.size());

	return color(redSum, greenSum, blueSum);
}

void draw() {
	background(0);
	if(frame % (framesPerUpdate + 1) == 0 && frame != 0) {
		updateBoard();
		for (int y = 0; y < numberOfRows; ++y)
			for (int x = 0; x < numberOfColums; ++x) {
				cells[x][y].draw(cellSize);
			}
	}
	else {
		for (int y = 0; y < numberOfRows; ++y)
			for (int x = 0; x < numberOfColums; ++x)
				cells[x][y].draw(cellSize);

		float progress = float(frame % (framesPerUpdate + 1)) / framesPerUpdate;

		// TWISTING
		int i = 0;
		for (GameObject cell : getChangedCells()) {
			if(!cell.alive && cells[cell.x][cell.y].alive)
				switch(i % 3)
				{
					case 0:
						Twist twist = new Twist(new FloatVector(cell.x * cellSize, cell.y * cellSize), cellSize, cell.cellColor);
						twist.draw(progress);
						break;
					case 1:
						Implode implode = new Implode(new FloatVector(cell.x * cellSize, cell.y * cellSize), cellSize, cell.cellColor);
						implode.draw(progress);
						break;
					case 2:
						Fade fade = new Fade(new FloatVector(cell.x * cellSize, cell.y * cellSize), cellSize, cell.cellColor);
						fade.draw(progress);
						break;
				}
			i++;
		}

		// FADING
		// for (GameObject cell : getChangedCells()) {
		// 	if(!cell.alive && cells[cell.x][cell.y].alive){
		// 		Fade fade = new Fade(new FloatVector(cell.x * cellSize, cell.y * cellSize), cellSize, cell.cellColor);
		// 		fade.draw(progress);
		// 	}
		// }

		for (GameObject cell : getChangedCells()) {
			if(!(cell.alive && !cells[cell.x][cell.y].alive))
				continue;

			ArrayList<Slide> slides = new ArrayList<Slide>();
			for (int dx = -1; dx < 2; dx++)
				for (int dy = -1; dy < 2; dy++)
					if(dy != 0 || dx != 0)
						if(cell.x + dx >= 0 && cell.x + dx < numberOfColums)
							if(cell.y + dy >= 0 && cell.y + dy < numberOfRows)
								if(cells[cell.x + dx][cell.y + dy].alive)
									slides.add(
										new Slide(
											new FloatVector(
												(cell.x + dx) * cellSize, 
												(cell.y + dy) * cellSize),
											new FloatVector(
												(cell.x) * cellSize, 
												(cell.y) * cellSize), 
											cellSize,
											cells[cell.x + dx][cell.y + dy].cellColor));

			color childColor = getResultingColor(cell.x, cell.y);
			for (Slide slide : slides) {
				slide.childColor = childColor;
				slide.draw(progress);
			}
		}
	}
	frame++;
}