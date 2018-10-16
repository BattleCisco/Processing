public class GameObject {
	int x, y; 
	boolean alive;
	color cellColor;

	public GameObject (int x, int y, color cellColor, boolean alive) {
		this.x = x;
		this.y = y;
		this.cellColor = cellColor;
		this.alive = alive;
	}

	public GameObject (GameObject cell, color cellColor, boolean alive) {
		this.x = cell.x;
		this.y = cell.y;
		this.cellColor = cellColor;
		this.alive = alive;
	}

	public GameObject (GameObject cell) {
		this.x = cell.x;
		this.y = cell.y;
		this.cellColor = cell.cellColor;
		this.alive = cell.alive;
	}

	public void draw(float cellSize) {
		if(this.alive)
		{
			fill(this.cellColor);
		}
		else
		{
			fill(0);
		}

		stroke(0);
		rect(
			width_offset + this.x * cellSize, 
			this.y * cellSize, 
			cellSize, 
			cellSize);
	}

	public boolean equals(GameObject other) {
		if(this.x != other.x)
			return false;

		else if (this.y != other.y)
			return false;

		else if (this.alive != other.alive)
			return false;

		return true;
	}

}