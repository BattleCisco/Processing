class SuperHeavyPlanet {
    public float diameter, gravity;
    public FloatVector position, velocity;
    public color planetColor;

    SuperHeavyPlanet (float diameter, float gravity, FloatVector position, color planetColor) {
        this.diameter = diameter;
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

    public void draw(FloatVector playerPosition) {
        stroke(this.planetColor);
        ellipse(this.position.x - playerPosition.x, this.position.y - playerPosition.y, diameter, diameter);
    }
}