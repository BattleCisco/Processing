import java.util.ArrayList;
import java.util.ListIterator;
import java.text.DecimalFormat;

int frame=0;
MessageList chatlog;
FiaManager fm;

void setup() {
	size(1280, 720);
	strokeWeight(1.5);
  	stroke(255);

  	float yposition = 355;
	float xposition = 530;
	float rotation = 0; //frame % 360;
	float scalar = 1.0;
	chatlog = new MessageList(
		new Text(
			new FloatVector(-151, -337), 
			20.0, 
			"Logbook:", 
			color(0, 0, 0)), 
		new Rectangle(
			new FloatVector(0, 0), 
			new FloatVector(405, 702), 
			color(61, 58, 58)), 
		new Rectangle(
			new FloatVector(0, 13), 
			new FloatVector(386, 660), 
			color(181, 188, 181)), 
		new FloatVector(1066, 361), //358, 1075), 
		rotation, 
		scalar
	);
	// for (int i = 0; i < 40; ++i) {
	//  	chatlog.add_message("Lorem ipsum dolor sit amet, consectetur adipiscing elit");
	// }

	//Actual Fia

	Player p1 = new Player(Team.GREEN, "Green");
	ClassicPiece piece = new ClassicPiece(p1.team);
	piece.x_int = 6;
	piece.y_int = 10;
	piece.hasExitedNest = true;
	p1.addPiece(piece);
	ClassicPiece piece2 = new ClassicPiece(p1.team);
	piece2.x_int = 4;
	piece2.y_int = 10;
	piece2.hasExitedNest = true;
	p1.addPiece(piece);
	p1.addPiece(piece2);
	p1.addPiece(new ClassicPiece(p1.team));
	p1.addPiece(new ClassicPiece(p1.team));

	Player p2 = new Player(Team.YELLOW, "Yellow");
	p2.addPiece(new ClassicPiece(p2.team));
	p2.addPiece(new ClassicPiece(p2.team));
	p2.addPiece(new ClassicPiece(p2.team));
	p2.addPiece(new ClassicPiece(p2.team));

	Player p3 = new Player(Team.RED, "Red");
	p3.addPiece(new ClassicPiece(p3.team));
	p3.addPiece(new ClassicPiece(p3.team));
	p3.addPiece(new ClassicPiece(p3.team));
	p3.addPiece(new ClassicPiece(p3.team));

	Player p4 = new Player(Team.BLUE, "Blue");
	p4.addPiece(new ClassicPiece(p4.team));
	p4.addPiece(new ClassicPiece(p4.team));
	p4.addPiece(new ClassicPiece(p4.team));
	p4.addPiece(new ClassicPiece(p4.team));

	Player[] players = {p1, p2, p3, p4};

	fm = new FiaManager(
		new Rectangle(
			new FloatVector(0, 0), 
			new FloatVector(600, 600), 
			color(181, 188, 181)), 
		new FloatVector(xposition, yposition), 
		rotation, 
		scalar,
		11,
		new FloatVector(273, 273),
		new FloatVector(324, 324),
		players
	);
}

void draw() {
	background(51, 4, 4);
	fm.draw();
	chatlog.draw();
	
	if(frame % 60 == 0)
		fm.stepPiece(fm.players[0].pieces.get(0));

	frame++;
}

void keyPressed() {
	println("if(keyCode == " + keyCode + "){} //" + key);
	if(keyCode == 48){} //0
	if(keyCode == 56){} //8
	if(keyCode == 57){} //9
	if(keyCode == 81){} //q
	if(keyCode == 87){} //w
	if(keyCode == 69){} //e
	if(keyCode == 84){} //t
	if(keyCode == 89){} //y
	if(keyCode == 85){} //u
	if(keyCode == 73){} //i
	if(keyCode == 79){} //o
	if(keyCode == 80){} //p
	if(keyCode == 65){} //a
	if(keyCode == 83){} //s
	if(keyCode == 68){} //d
	if(keyCode == 70){} //f
	if(keyCode == 71){} //g
	if(keyCode == 72){} //h
	if(keyCode == 74){} //j
	if(keyCode == 75){} //k
	if(keyCode == 76){} //l
	if(keyCode == 90){} //z
	if(keyCode == 88){} //x
	if(keyCode == 67){} //c
	if(keyCode == 86){} //v
	if(keyCode == 66){} //b
	if(keyCode == 78){} //n
	if(keyCode == 77){} //m

	
		
	
	
	if(key == CODED)
	{
		if(keyCode == 49){} //1
		if(keyCode == 50){} //2
		if(keyCode == 51){} //3
		if(keyCode == 52){} //4
		
		if(keyCode == 82) // R - Rolling the dice
		{

		if(fm.stage == Stage.WAITING_TO_ROLL){
			int diceroll = (int) ((random(0, 1) * 100) % 6) + 1;
			fm.current_diceroll = diceroll;
			chatlog.add_message("Player #"  + (fm.current_player + 1) + " rolled a " + diceroll);
			fm.stage = Stage.WAITING_TO_PICK_CHOICE;
		}

		if(keyCode == 53){} //5
			if(fm.stage == Stage.WAITING_TO_PICK_CHOICE)
				if(fm.summon1Piece1Step(fm.players[fm.current_player], fm.current_diceroll)){
					fm.players[fm.current_player].summonPiece();
					chatlog.add_message("Player #"  + (fm.current_player + 1) + " summoned one piece");
				}
				

		if(keyCode == 54){} //6
			if(fm.stage == Stage.WAITING_TO_PICK_CHOICE)
				if(fm.summon2Piece1Step(fm.players[fm.current_player], fm.current_diceroll)){
					fm.players[fm.current_player].summonPiece();
					fm.players[fm.current_player].summonPiece();
					chatlog.add_message("Player #"  + (fm.current_player + 1) + " summoned two pieces");
				}


		if(keyCode == 55){} //7
			if(fm.stage == Stage.WAITING_TO_PICK_CHOICE)
				if(fm.summon1Piece6Step(fm.players[fm.current_player], fm.current_diceroll))
			}
	}

}