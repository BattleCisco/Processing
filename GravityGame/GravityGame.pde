import java.text.MessageFormat;
import java.text.DecimalFormat;

PlayerShip player = new PlayerShip(37, 38, 39, 0.0, 0.0, color(0, 200, 200));
//PlayerShip player2 = new PlayerShip(38, 40, 0, 0, 10, 90);

SuperHeavyPlanet[] planets = {
	new SuperHeavyPlanet(20.0, 2.0, new FloatVector(0, 0), color(255, 0, 0)), 
	new SuperHeavyPlanet(20.0, 3.0, new FloatVector(0, 0), color(0, 255, 0)),
	new SuperHeavyPlanet(20.0, 5.0, new FloatVector(0, 0), color(0, 0, 255)),
	new SuperHeavyPlanet(20.0, 300.0, new FloatVector(-1000, -1000), color(255, 0, 0))};

int frame = 0;
float player_speed = 6;
PFont font;

float scalar = 2.0;

void setup() {
	size(1280, 720);
	player.position = new FloatVector(width / 2, height / 2);
	planets[0].position = new FloatVector(width / 2 + width / 4, height / 2 + height / 4);
	planets[1].position = new FloatVector(width / 2 + width / 4, height / 2 - height / 4);
	planets[2].position = new FloatVector(width / 2 - width / 4 - width / 8, height / 2);
	strokeWeight(1.5);
  	stroke(255);
	font = createFont("bit5x3.ttf", 120);
}

void draw() {
	translate(width / 2, height / 2);
  	scale(1/scalar);
	background(0);
    for(SuperHeavyPlanet shp: planets)
	{
    	FloatVector playerToPlanet = shp.affecting_gravity(player);
    	player.velocity.addTo(playerToPlanet.multiply(shp.gravity / playerToPlanet.magNoSqrt()));
		shp.draw(player.position);
	}
    
	int def=100;
	strokeWeight(1.5);
	line(
		-(width/2) * scalar, 
		(def - (height/2)) * scalar, 
		(def - (width/2)) * scalar, 
		(def - (height/2)) * scalar);
	line(
		(def - (width/2)) * scalar, 
		-(height/2) * scalar, 
		(def - (width/2)) * scalar, 
		(def - (height/2)) * scalar);

	line(
		(def/2 - (width/2)) * scalar, 
		(def/2 - (height/2)) * scalar, 
		(def/2 + cos(radians(player.direction)) * def/2 - (width/2)) * scalar, 
		(def/2 + sin(radians(player.direction)) * def/2 - (height/2)) * scalar);

	stroke(0, 255, 0);
	float rad = getAngleFromVector(player.velocity);
	line(
		(def/2 - (width/2)) * scalar, 
		(def/2 - (height/2)) * scalar,
		(def/2 + cos(rad) * def/2 - (width/2)) * scalar, 
		(def/2 + sin(rad) * def/2 - (height/2)) * scalar);
	// draw_spaceship(def/2, def/2, 0.0);
	player.update();
    player.draw();
	
	textAlign(LEFT, CENTER);
	textSize(40);
	DecimalFormat df = new DecimalFormat();
	df.setMaximumFractionDigits(1);

	text("Velocity: " + df.format(this.player.velocity.mag()) + "p/s", 5 - width / 2 * scalar, height / 2 * scalar - 20);
	text("X: " + df.format(this.player.position.x) + "p", 5 - width / 2 * scalar, height / 2 * scalar - 70);
	text("Y: " + df.format(this.player.position.y) + "p", 5 - width / 2 * scalar, height / 2 * scalar - 120);
	translate(width / -2, height / -2);
  	scale(scalar);
}

void keyPressed() {
	//println(key + " is pressed.", keyCode);
	player.pressKey();
	//player2.pressKey();
}

void keyReleased(){
	//println(key + " is released.");
	player.releaseKey();
	//player2.releaseKey();
}

float getAngleFromVector(FloatVector vector) {
	if(vector.y > 0){
		if(vector.x > 0)
			return asin(vector.y/vector.mag());
		else
			return radians(180) - asin(vector.y/vector.mag());
	}
	else if (vector.y < 0) {
		if(vector.x > 0)
			return asin(vector.y/vector.mag());
		else
			return radians(180) - asin(vector.y/vector.mag());
	}
	else
		return 0.0;
}