public class Simulation {
	int generation;
	int deadCells = 0;
	Cell[] cells;
	ArrayList<Animation> animations = new ArrayList<Animation>();

	final float cellSize;
	
	public Simulation (float cellSize) {
		this.generation = 0;
		this.deadCells = 0;
		this.cellSize = cellSize;
		this.cells = new Cell[this.getNumberOfColumns() * this.getNumberOfRows()];

		for (int y = 0; y < this.getNumberOfRows(); ++y)
			for (int x = 0; x < this.getNumberOfColumns(); ++x) {
				this.setCell(new Cell(x, y, color(0), false));
				if (random(0, 1) < fillPercentage) {
					Cell cell = this.getCell(x, y);
					cell.alive = true;
					cell.cellColor = color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255));
				}
			}
	}

	public Simulation (Simulation other) {
		this.generation = other.generation;
		this.deadCells = other.deadCells;
		this.cellSize = other.cellSize;
		this.cells = new Cell[other.getNumberOfColumns() * other.getNumberOfRows()];

		for (int y = 0; y < other.getNumberOfRows(); ++y)
			for (int x = 0; x < other.getNumberOfColumns(); ++x) {
				this.setCell(new Cell(other.getCell(x, y)));
			}
	}

	public boolean equals(Simulation other) {
		if(this.cellSize != other.cellSize)
			return false;

		for (int y = 0; y < this.getNumberOfRows(); ++y)
			for (int x = 0; x < this.getNumberOfColumns(); ++x) {
				Cell cell = this.getCell(x, y);
				Cell otherCell = other.getCell(x, y);

				if (!cell.equals(otherCell)) {
					return false;
				}
			}

		return true;
	}

	public int getNumberOfColumns() {return (int) Math.floor(newWidth / this.cellSize);}
	public int getNumberOfRows() {return (int) Math.floor(height / this.cellSize);}
	
	public Cell getCell(int x, int y) {return this.cells[x + this.getNumberOfColumns() * y];}
	public void setCell(Cell cell) {this.cells[cell.x + this.getNumberOfColumns() * cell.y] = cell;}
	public void setCell(int x, int y, boolean alive) {
		color randomColor = color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255));
		Cell cell = new Cell(x, y, randomColor, alive);
		this.setCell(cell);
	}
	public void setCell(int x, int y, color c, boolean alive) {
		Cell cell = new Cell(x, y, c, alive);
		this.setCell(cell);
	}

	public void spawnAcorn(int x, int y) {
		this.setCell(x + 3, y + 2, color(255, 0, 0), true);
		this.setCell(x + 2, y + 4, color(0, 255, 0), true);
		this.setCell(x + 3, y + 4, color(255, 0, 255), true);
		this.setCell(x + 5, y + 3, color(0, 255, 0), true);
		this.setCell(x + 6, y + 4, color(255, 0, 255), true);
		this.setCell(x + 7, y + 4, color(0, 255, 0), true);
		this.setCell(x + 8, y + 4, color(255, 255, 0), true);
	}
	public void spawnGliderGun(int x, int y, int dx, int dy) {
		this.setCell(x + 25 * dx, y + 1 * dy, true);
		this.setCell(x + 23 * dx, y + 2 * dy, true);
		this.setCell(x + 25 * dx, y + 2 * dy, true);
		this.setCell(x + 13 * dx, y + 3 * dy, true);
		this.setCell(x + 14 * dx, y + 3 * dy, true);
		this.setCell(x + 21 * dx, y + 3 * dy, true);
		this.setCell(x + 22 * dx, y + 3 * dy, true);
		this.setCell(x + 35 * dx, y + 3 * dy, true);
		this.setCell(x + 36 * dx, y + 3 * dy, true);
		this.setCell(x + 12 * dx, y + 4 * dy, true);
		this.setCell(x + 16 * dx, y + 4 * dy, true);
		this.setCell(x + 21 * dx, y + 4 * dy, true);
		this.setCell(x + 22 * dx, y + 4 * dy, true);
		this.setCell(x + 35 * dx, y + 4 * dy, true);
		this.setCell(x + 36 * dx, y + 4 * dy, true);
		this.setCell(x + 1 * dx, y + 5 * dy, true);
		this.setCell(x + 2 * dx, y + 5 * dy, true);
		this.setCell(x + 11 * dx, y + 5 * dy, true);
		this.setCell(x + 17 * dx, y + 5 * dy, true);
		this.setCell(x + 21 * dx, y + 5 * dy, true);
		this.setCell(x + 22 * dx, y + 5 * dy, true);
		this.setCell(x + 1 * dx, y + 6 * dy, true);
		this.setCell(x + 2 * dx, y + 6 * dy, true);
		this.setCell(x + 11 * dx, y + 6 * dy, true);
		this.setCell(x + 15 * dx, y + 6 * dy, true);
		this.setCell(x + 17 * dx, y + 6 * dy, true);
		this.setCell(x + 18 * dx, y + 6 * dy, true);
		this.setCell(x + 23 * dx, y + 6 * dy, true);
		this.setCell(x + 25 * dx, y + 6 * dy, true);
		this.setCell(x + 11 * dx, y + 7 * dy, true);
		this.setCell(x + 17 * dx, y + 7 * dy, true);
		this.setCell(x + 25 * dx, y + 7 * dy, true);
		this.setCell(x + 12 * dx, y + 8 * dy, true);
		this.setCell(x + 16 * dx, y + 8 * dy, true);
		this.setCell(x + 13 * dx, y + 9 * dy, true);
		this.setCell(x + 14 * dx, y + 9 * dy, true);
		this.setCell(x + 8 * dx, y + 2 * dy, true);
	}

	public int getAliveNeighbors(Cell cell) {
		int numberOfAliveNeighbors = 0;
		for (int dx = -1; dx < 2; dx++)
			for (int dy = -1; dy < 2; dy++)
				if(dy != 0 || dx != 0)
					if(cell.x + dx >= 0 && cell.x + dx < this.getNumberOfColumns())
						if(cell.y + dy >= 0 && cell.y + dy < this.getNumberOfRows())
							if(this.getCell(cell.x + dx, cell.y + dy).alive)
								numberOfAliveNeighbors += 1;
		return numberOfAliveNeighbors;
	}

	public ArrayList<Cell> getChangedCells() {
		ArrayList<Cell> changedCells = new ArrayList<Cell>();

		for (int y = 0; y < this.getNumberOfRows(); ++y)
			for (int x = 0; x < this.getNumberOfColumns(); ++x) {
				int numberOfAliveNeighbors = getAliveNeighbors(this.getCell(x, y));
				
				Cell possiblyChangedCell;
				if(this.getCell(x, y).alive) {
					if(numberOfAliveNeighbors == 2 || numberOfAliveNeighbors == 3)
						possiblyChangedCell = this.getCell(x, y);
					else
						possiblyChangedCell = new Cell(this.getCell(x, y), this.getCell(x, y).cellColor, false);
				}
				else {
					if(numberOfAliveNeighbors == 3)
					{
						int c;
						if(random(0, 1) < chanceOfMutation){
							c = color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255));
						}
						else {
							c = getInheritedColor(x, y);
						}
						possiblyChangedCell = new Cell(this.getCell(x, y), c, true);
					}
					else
						possiblyChangedCell = this.getCell(x, y);
				}

				if(this.getCell(x, y).alive != possiblyChangedCell.alive)
					changedCells.add(possiblyChangedCell);
			}

		return changedCells;
	}

	public ArrayList<Cell> getAliveCells() {
		ArrayList<Cell> aliveCells = new ArrayList<Cell>();

		for (int y = 0; y < this.getNumberOfRows(); ++y)
			for (int x = 0; x < this.getNumberOfColumns(); ++x) {
				Cell cell = this.getCell(x, y);
				
				if(cell.alive)
					aliveCells.add(cell);
			}

		return aliveCells;
	}

	public color getInheritedColor(int x, int y) {
		ArrayList<Cell> aliveCells = new ArrayList<Cell>();
		for (int dx = -1; dx < 2; dx++)
			for (int dy = -1; dy < 2; dy++)
				if(dy != 0 || dx != 0)
					if(x + dx >= 0 && x + dx < this.getNumberOfColumns())
						if(y + dy >= 0 && y + dy < this.getNumberOfRows())
							if(this.getCell(x + dx, y + dy).alive)
								aliveCells.add(this.getCell(x + dx, y + dy));

		int redSum=0, greenSum=0, blueSum=0;
		for (Cell cell : aliveCells) {
			redSum += red(cell.cellColor);
			greenSum += green(cell.cellColor);
			blueSum += blue(cell.cellColor);
		}
		if(aliveCells.size() != 0){
			redSum = int(redSum / aliveCells.size());
			greenSum = int(greenSum / aliveCells.size());
			blueSum = int(blueSum / aliveCells.size());
		}
		else {
			redSum = (int) random(0, 255);
			greenSum = (int) random(0, 255);
			blueSum = (int) random(0, 255);
		}
		return color(redSum, greenSum, blueSum);
	}

	public void step() {
		ArrayList<Cell> changedCells = getChangedCells();
		for(Cell cell : changedCells) {
			if(!cell.alive)
				this.deadCells++;
		}

		for (Cell cell : changedCells) {
			this.setCell(new Cell(cell));
		}

		this.generation++;
	}

	public void prepareAnimations() {
		this.animations.clear();
		int i = 0;
		for (Cell cell : getChangedCells()) {
			if(!cell.alive && this.getCell(cell.x, cell.y).alive) {
				switch(i % 3) {
					case 0:
						Twist twist = new Twist(new FloatVector(cell.x * this.cellSize, cell.y * this.cellSize), cellSize, cell.cellColor);
						this.animations.add(twist);
						break;
					case 1:
						Implode implode = new Implode(new FloatVector(cell.x * this.cellSize, cell.y * this.cellSize), cellSize, cell.cellColor);
						this.animations.add(implode);
						break;
					case 2:
						Fade fade = new Fade(new FloatVector(cell.x * this.cellSize, cell.y * this.cellSize), cellSize, cell.cellColor);
						this.animations.add(fade);
						break;
				}
				i++;
			}
		}

		for (Cell cell : getChangedCells()) {
			if(!(cell.alive && !this.getCell(cell.x, cell.y).alive))
				continue;

			ArrayList<Slide> slides = new ArrayList<Slide>();
			for (int dx = -1; dx < 2; dx++)
				for (int dy = -1; dy < 2; dy++)
					if(dy != 0 || dx != 0)
					{
						if(cell.x + dx >= 0 && cell.x + dx < this.getNumberOfColumns())
							if(cell.y + dy >= 0 && cell.y + dy < this.getNumberOfRows())
							{	
								Cell slidingCell = this.getCell(cell.x + dx, cell.y + dy);
								if(slidingCell.alive)
									slides.add(
										new Slide(
											new FloatVector(
												(cell.x + dx) * cellSize, 
												(cell.y + dy) * cellSize),
											new FloatVector(
												(cell.x) * cellSize, 
												(cell.y) * cellSize), 
											cellSize,
											slidingCell.cellColor));
							}
					}

			color childColor = getInheritedColor(cell.x, cell.y);
			for (Slide slide : slides) {
				slide.childColor = childColor;
				this.animations.add(slide);
			}
		}
	}

	public void draw() {
		float progress = float(frame % (framesPerUpdate + 1)) / framesPerUpdate;
	
		for (int y = 0; y < this.getNumberOfRows(); ++y)
			for (int x = 0; x < this.getNumberOfColumns(); ++x) {
				Cell cell = this.getCell(x, y);
				cell.draw(this.cellSize);
			}

		for(Animation animation : this.animations)
			animation.draw(progress);
	}

	public void mousePressed() {
		if(mouseX - widthOffset < 0)
			return;

		if (mousePressed && (mouseButton == LEFT)) {
			int x = int((mouseX - widthOffset) / cellSize);
			int y = int(mouseY / cellSize);


			int c;
			if(random(0, 1) < chanceOfMutation) {
				c = color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255));
			}
			else {
				c = getInheritedColor(x, y);
			}
			this.setCell(new Cell(this.getCell(x, y), c, true));
		}

		else if (mousePressed && (mouseButton == RIGHT)) {
			int x = int((mouseX - widthOffset) / cellSize);
			int y = int(mouseY / cellSize);

			int c;
			if(random(0, 1) < chanceOfMutation) {
				c = color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255));
			}
			else {
				c = getInheritedColor(x, y);
			}
			this.setCell(new Cell(this.getCell(x, y), c, false));
		}

		this.prepareAnimations();
	}

	public void killAllCells() {
		for (int i = 0; i < this.cells.length; ++i){
			Cell cell = this.cells[i];
			cell.alive = false;
		}
	}
}