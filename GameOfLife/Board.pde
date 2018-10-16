public class Board {
	int generation;
	GameObject[] cells;
	ArrayList<Animation> animations = new ArrayList<Animation>();

	final float cellSize;
	
	public Board (float cellSize) {
		this.generation = 0;
		this.cellSize = cellSize;
		this.cells = new GameObject[this.getNumberOfColumns() * this.getNumberOfRows()];

		for (int y = 0; y < this.getNumberOfRows(); ++y)
			for (int x = 0; x < this.getNumberOfColumns(); ++x) {
				this.setCell(x, y, new GameObject(x, y, color(0), false));
				if (random(0, 1) < fillPercentage) {
					GameObject cell = this.getCell(x, y);
					cell.alive = true;
					cell.cellColor = color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255));
				}
			}
	}

	public Board (Board board) {
		this.generation = board.generation;
		this.cellSize = board.cellSize;
		this.cells = new GameObject[board.getNumberOfColumns() * board.getNumberOfRows()];

		for (int y = 0; y < board.getNumberOfRows(); ++y)
			for (int x = 0; x < board.getNumberOfColumns(); ++x) {
				this.setCell(x, y, new GameObject(board.getCell(x, y)));
			}
	}

	public int getNumberOfColumns() {return (int) Math.floor(new_width / this.cellSize);}
	public int getNumberOfRows() {return (int) Math.floor(height / this.cellSize);}
	
	public GameObject getCell(int x, int y) {return cells[x + this.getNumberOfColumns() * y];}
	public void setCell(int x, int y, GameObject cell) {this.cells[x + this.getNumberOfColumns() * y] = cell;}
	
	public void spawnAcorn(int x, int y) {
		this.spawnAliveCell(x + 3, y + 2, color(255, 0, 0));

		this.spawnAliveCell(x + 2, y + 4, color(0, 255, 0));
		this.spawnAliveCell(x + 3, y + 4, color(255, 0, 255));

		this.spawnAliveCell(x + 5, y + 3, color(0, 255, 0));

		this.spawnAliveCell(x + 6, y + 4, color(255, 0, 255));
		this.spawnAliveCell(x + 7, y + 4, color(0, 255, 0));
		this.spawnAliveCell(x + 8, y + 4, color(255, 255, 0));
	}

	public int getAliveNeighbors(GameObject cell) {
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

	public ArrayList<GameObject> getChangedCells() {
		ArrayList<GameObject> changedCells = new ArrayList<GameObject>();

		for (int y = 0; y < this.getNumberOfRows(); ++y)
			for (int x = 0; x < this.getNumberOfColumns(); ++x){
				int numberOfAliveNeighbors = getAliveNeighbors(this.getCell(x, y));
				
				GameObject possiblyChangedCell;
				if(this.getCell(x, y).alive)
				{
					if(numberOfAliveNeighbors == 2 || numberOfAliveNeighbors == 3)
						possiblyChangedCell = this.getCell(x, y);
					else
						possiblyChangedCell = new GameObject(this.getCell(x, y), this.getCell(x, y).cellColor, false);
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
						possiblyChangedCell = new GameObject(this.getCell(x, y), c, true);
					}
					else
						possiblyChangedCell = this.getCell(x, y);
				}

				if(this.getCell(x, y).alive != possiblyChangedCell.alive)
					changedCells.add(possiblyChangedCell);
			}

		return changedCells;
	}

	public void spawnAliveCell(int x, int y, color c) {
		this.setCell(x, y, new GameObject(x, y, color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255)), true));
		this.getCell(x, y).cellColor = c;
	}

	public color getResultingColor(int x, int y) {
		ArrayList<GameObject> aliveCells = new ArrayList<GameObject>();
		for (int dx = -1; dx < 2; dx++)
			for (int dy = -1; dy < 2; dy++)
				if(dy != 0 || dx != 0)
					if(x + dx >= 0 && x + dx < this.getNumberOfColumns())
						if(y + dy >= 0 && y + dy < this.getNumberOfRows())
							if(this.getCell(x + dx, y + dy).alive)
								aliveCells.add(this.getCell(x + dx, y + dy));

		int redSum=0, greenSum=0, blueSum=0;
		for (GameObject cell : aliveCells) {
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

	public void mousePressed(){
		if(mouseX - width_offset < 0)
			return;

		if (mousePressed && (mouseButton == LEFT)) {
			int x = int((mouseX - width_offset) / cellSize);
			int y = int(mouseY / cellSize);

			if(random(0, 1) < chanceOfMutation){
				int c;
				if(random(0, 1) < chanceOfMutation){
					c = color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255));
				}
				else {
					c = getResultingColor(x, y);
				}
				this.setCell(x, y, new GameObject(this.getCell(x, y), c, true));
			}
		} 
		else if (mousePressed && (mouseButton == RIGHT)) {
			int x = int((mouseX - width_offset) / cellSize);
			int y = int(mouseY / cellSize);

			if(random(0, 1) < chanceOfMutation){
				int c;
				if(random(0, 1) < chanceOfMutation){
					c = color((int) random(0, 255), (int) random(0, 255), (int) random(0, 255));
				}
				else {
					c = getResultingColor(x, y);
				}
				this.setCell(x, y, new GameObject(this.getCell(x, y), c, false));
			}
		}
	}
	
	public void update() {
		ArrayList<GameObject> changedCells = getChangedCells();

		for (GameObject cell : changedCells) {
			this.setCell(cell.x, cell.y, new GameObject(cell));
		}

		this.generation++;
	}

	public void prepareAnimations() {
		this.animations.clear();
		int i = 0;
		for (GameObject cell : getChangedCells()) {
			if(!cell.alive && this.getCell(cell.x, cell.y).alive)
				switch(i % 3)
				{
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

		for (GameObject cell : getChangedCells()) {
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
								GameObject slidingCell = this.getCell(cell.x + dx, cell.y + dy);
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

			color childColor = getResultingColor(cell.x, cell.y);
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
				GameObject cell = board.getCell(x, y);
				cell.draw(this.cellSize);
			}

		for(Animation animation : this.animations)
			animation.draw(progress);
	}

	public boolean equals(Board other) {
		if(this.cellSize != other.cellSize)
			return false;

		for (int y = 0; y < this.getNumberOfRows(); ++y)
			for (int x = 0; x < this.getNumberOfColumns(); ++x) {
				GameObject cell = this.getCell(x, y);
				GameObject otherCell = other.getCell(x, y);

				if (!cell.equals(otherCell)) {
					return false;
				}
			}

		return true;
	}
}