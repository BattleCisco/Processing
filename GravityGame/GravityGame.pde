PlayerShip player1 = new PlayerShip(37, 38, 39, 0.0, 0.0, color(0, 200, 200));
//PlayerShip player2 = new PlayerShip(38, 40, 0, 0, 10, 90);

PlayerShip[] players = {player1};//, player2};

SuperHeavyPlanet[] planets = {
	new SuperHeavyPlanet(20.0, 2.0, new FloatVector(0, 0), color(255, 0, 0)), 
	new SuperHeavyPlanet(20.0, 3.0, new FloatVector(0, 0), color(0, 255, 0)),
	new SuperHeavyPlanet(20.0, 5.0, new FloatVector(0, 0), color(0, 0, 255))};

int frame = 0;
float player_speed = 6;
PFont font;

void setup() {
	size(640, 480);
	player1.position = new FloatVector(width / 2, height / 2);
	planets[0].position = new FloatVector(width / 2 + width / 4, height / 2 + height / 4);
	planets[1].position = new FloatVector(width / 2 + width / 4, height / 2 - height / 4);
	planets[2].position = new FloatVector(width / 2 - width / 4 - width / 8, height / 2);
	strokeWeight(1.5);
  	stroke(255);
	font = createFont("bit5x3.ttf", 120);
}

void draw() {

	background(0);
	
	for(PlayerShip p: players)
	{
		//println(p.position.x, p.position.y);
	 	p.update();
	    p.draw();

	    for(SuperHeavyPlanet shp: planets)
	    {
	    	//println(p.position.x, p.position.y);
	    	FloatVector playerToPlanet = shp.affecting_gravity(p);
	    	playerToPlanet.printData();
	    	p.velocity.addTo(playerToPlanet.multiply(shp.gravity / playerToPlanet.magNoSqrt()));
	    }
	}
	for(SuperHeavyPlanet shp: planets)
	{
		shp.draw();
	}

	int def=100;
	strokeWeight(1.5);
	line(def, 0, def, def);
	line(0, def, def, def);
	line(def/2, def/2, def/2 + cos(radians(player1.direction)) * def/2, def/2 + sin(radians(player1.direction)) * def/2);
	// draw_spaceship(def/2, def/2, 0.0);
}

void keyPressed() {
	//println(key + " is pressed.", keyCode);
	player1.pressKey();
	//player2.pressKey();
}

void keyReleased(){
	//println(key + " is released.");
	player1.releaseKey();
	//player2.releaseKey();
}