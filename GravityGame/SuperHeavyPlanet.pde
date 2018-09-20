class SuperHeavyPlanet {
    public float _width, gravity;
    public FloatVector position, velocity;
    public color planetColor;

    SuperHeavyPlanet (float _width, float gravity, FloatVector position, color planetColor) {
        this._width = _width;
        this.gravity = gravity;
        this.position = position;
        this.planetColor = planetColor;
    }

   	public FloatVector affecting_gravity(PlayerShip ps) {
   		FloatVector playerPosition = ps.position;
   		FloatVector planetPosition = position;


   		FloatVector playerToPlanet = planetPosition.subtract(playerPosition);
   		return playerToPlanet;
   	}

	public void draw() {
		stroke(this.planetColor);
		ellipse(this.position.x, this.position.y, _width, _width);
	}
}