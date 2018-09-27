public class FiaManager {
    public Rectangle board;
    public FloatVector position;
    public float rotation, scalar;

    public Player[] players;

    public int amountOfPositions;
    public FloatVector positionsStart;
    public FloatVector positionsEnd;

    public float baseBallRadius = 32.0;

    public Stage stage = Stage.WAITING_TO_ROLL;
    public float animation_progress = 0;
    public int current_player = 0;
    public int current_diceroll = 0;

    public MessageList choices;

    public FiaManager (
            Rectangle board,
            FloatVector position,
            float rotation,
            float scalar,
            int amountOfPositions,
            FloatVector positionsStart,
            FloatVector positionsEnd,
            Player[] players) {
        this.board = board;
        this.position = position;
        this.rotation = rotation;
        this.scalar = scalar;

        this.amountOfPositions = amountOfPositions;
        this.positionsStart = positionsStart;
        this.positionsEnd = positionsEnd;

        this.players = players;

        this.choices = new MessageList(
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
                0,
                1.0
        );
    }

    public FloatVector getPostionsSumVector() {
        return this.positionsStart.add(this.positionsEnd);
    }

    public void drawPiece(ClassicPiece piece, int x, int y, int i, Team team) {
        //FloatVector positionToDraw = this.getPosition(x, y);
        color teamColor = getTeamColor(team);
        piece.draw(this, x, y, i, teamColor);
    }

    public FloatVector getPosition(int x, int y) {
        FloatVector sizeVector = this.getPostionsSumVector();
        float xPosition = this.scalar * ((sizeVector.x / this.amountOfPositions) * x - this.positionsStart.x);
        float yPosition = this.scalar * ((sizeVector.y / this.amountOfPositions) * y - this.positionsStart.y);
        return new FloatVector(xPosition, yPosition);
    }

    public void drawEllipse(int x, int y, color pieceColour)
    {
        translate(position.x, position.y);
        rotate(radians(this.rotation));
        FloatVector coords = this.getPosition(x, y);
        stroke(0);
        fill(pieceColour);
        ellipse(
                coords.x,
                coords.y,
                this.baseBallRadius,
                this.baseBallRadius);
        rotate(-radians(this.rotation));
        translate(-position.x, -position.y);
    }

    public void drawPlayers() {
        for (Player player : this.players) {
            ArrayList<ClassicPiece> nestedPieces = new ArrayList<ClassicPiece>();

            for (int i=0; i < player.pieces.size(); i++) {
                if(!player.pieces.get(i).hasExitedNest)
                    nestedPieces.add(player.pieces.get(i));

                for (int j=0; j < player.pieces.size(); j++) {
                    if(player.pieces.get(j).hasExitedNest)
                        this.drawPiece(
                                player.pieces.get(j),
                                player.pieces.get(j).x_int,
                                player.pieces.get(j).y_int,
                                nestedPieces.size() + j,
                                player.team);
                }
            }
            int[] positions = getNestStartPosion(player.team);
            for (int i = 0; i < nestedPieces.size(); ++i) {
                int x = i;
                int y = 0;
                if(x > 1)
                {
                    y = int(x/2);
                    x -= 2;
                }
                x += positions[0];
                y += positions[1];
                this.drawPiece(
                        player.pieces.get(i),
                        x,
                        y,
                        i,
                        player.team);
                // this.drawEllipse(
                // 	x,
                // 	y,
                // 	this.getTeamColor(nestedPieces.get(i).team)
                //);
            }
        }
    }

    public void draw() {
        this.board.draw(this.position, this.rotation, this.scalar);

        drawXLine(4, 0, 4, -1, color(255));
        drawXLine(6, 0, 4, -1, color(255));
        drawXLine(4, 6, 10, -1, color(255));
        drawXLine(6, 6, 10, -1, color(255));
        drawXLine(0, 4, 6, -1, color(255));
        drawXLine(10, 4, 6, -1, color(255));

        drawYLine(4, 0, 4, -1, color(255));
        drawYLine(6, 0, 4, -1, color(255));
        drawYLine(4, 6, 10, -1, color(255));
        drawYLine(6, 6, 10, -1, color(255));
        drawYLine(0, 4, 6, -1, color(255));
        drawYLine(10, 4, 6, -1, color(255));

        //Draws the colored circles.
        drawYLine(5, 1, 5, -1, color(0, 0, 255));
        drawYLine(5, 5, 9, -1, color(255, 255, 0));
        drawXLine(5, 1, 5, -1, color(255, 0, 0));
        drawXLine(5, 5, 9, -1, color(0, 255, 0));

        this.drawEllipse(6, 0, color(150, 150, 255));
        this.drawEllipse(4, 10, color(255, 255, 150));
        this.drawEllipse(0, 4, color(255, 150, 150));
        this.drawEllipse(10, 6, color(150, 255, 150));
        this.drawEllipse(5, 5, color(255));

        this.drawPlayers();

        if(this.stage == Stage.WAITING_TO_ROLL)
        {
        	this.choices.messages = this.getChoices();
        }
        else if (this.stage == Stage.WAITING_TO_ROLL) {
        	this.choices.messages = this.getChoices(this.current_diceroll, this.players[this.current_player]);
        }
        else{
        	this.choices.messages = new ArrayList<String>();
        }
        //this.drawChoices();

    }

    public ArrayList<String> getChoices() {
        ArrayList<String> choices = new ArrayList<String>();
        switch (this.stage) {
            case WAITING_TO_ROLL:
                choices.add("Press R to roll.");
        }
        return choices;
    }

    public ArrayList<String> getChoices(int diceroll, Player player) {
        ArrayList<String> choices = new ArrayList<String>();
        switch(this.stage)
        {
            case WAITING_TO_PICK_CHOICE:
                if(player.nestedPieces() > 2 && diceroll == 6)
                {
                    if(this.summon1Piece1Step(player, diceroll))
                        choices.add("Press 5 to summon two pieces at 1 step");

                    if(this.summon2Piece1Step(player, diceroll))
                        choices.add("Press 6 to summon two pieces at 1 step");

                    if(this.summon1Piece6Step(player, diceroll))
                        choices.add("Press 7 to summon one piece at 6 steps");

                    for (int i=0; i < player.pieces.size(); i++) {
                        if(player.pieces.get(i).hasExitedNest) {
                            if(this.testPathFor(player, player.pieces.get(i), diceroll))
                                choices.add("Press " + (i + 1) + " to walk " + diceroll + " steps");
                        }

                    }
                }
                return choices;
        }
        return new ArrayList<String>();
    }

    public boolean summon1Piece1Step(Player player, int diceroll){
    	int[] spawn_position = getTeamStarterCoords(player.team);
        if(!player.friendlyPieceAt(spawn_position[0], spawn_position[1]) && diceroll == 1 && player.nestedPieces() > 0)
            return true;
        return false;
    }

    public boolean summon2Piece1Step(Player player, int diceroll){
    	int[] spawn_position = getTeamStarterCoords(player.team);
        if(!player.friendlyPieceAt(spawn_position[0], spawn_position[1]) && diceroll == 6 && player.nestedPieces() > 1)
            return true;
        return false;
    }

    public boolean summon1Piece6Step(Player player, int diceroll){
        int[] spawn_position = getTeamStarterCoords(player.team);
        ClassicPiece dummyPiece = new ClassicPiece(player.team);
        dummyPiece.hasExitedNest = true;
        dummyPiece.x_int = spawn_position[0];
        dummyPiece.y_int = spawn_position[1];

        boolean passable_route = true;
        for(int i=0; i < diceroll; i++)
        {
            if(player.friendlyPieceAt(dummyPiece.x_int, dummyPiece.y_int))
            {
                passable_route = false;
            }
            this.stepPiece(dummyPiece);
        }

        return passable_route;
    }

    public boolean testPathFor(Player player, ClassicPiece piece, int diceroll) {
        ClassicPiece dummyPiece = new ClassicPiece(player.team);
        dummyPiece.hasExitedNest = true;
        dummyPiece.x_int = piece.x_int;
        dummyPiece.y_int = piece.x_int;

        boolean passable_route = true;
        for(int i=0; i < diceroll; i++)
        {
            if(player.friendlyPieceAt(dummyPiece.x_int, dummyPiece.y_int))
            {
                passable_route = false;
            }
            this.stepPiece(dummyPiece);
        }

        return passable_route;
    }

    public void drawXLine(int y, int start, int stop, int skip, color ballColor)
    {
        translate(position.x, position.y);
        rotate(radians(this.rotation));
        FloatVector start_coords = this.getPosition(start, y);
        FloatVector end_coords = this.getPosition(stop, y);
        stroke(0);
        line(start_coords.x, start_coords.y, end_coords.x, end_coords.y);
        rotate(-radians(this.rotation));
        translate(-position.x, -position.y);

        for (int i=start; i < stop + 1; i++) {
            if(i != skip) {
                this.drawEllipse(i, y, ballColor);
            }
        }
    }

    public void drawYLine(int y, int start, int stop, int skip, color ballColor)
    {
        translate(position.x, position.y);
        rotate(radians(this.rotation));
        FloatVector start_coords = this.getPosition(y, start);
        FloatVector end_coords = this.getPosition(y, stop);
        stroke(0);
        line(start_coords.x, start_coords.y, end_coords.x, end_coords.y);
        rotate(-radians(this.rotation));
        translate(-position.x, -position.y);

        for (int i=start; i < stop + 1; i++) {
            if(i != skip) {
                this.drawEllipse(y, i, ballColor);
            }
        }
    }

    public void stepPiece(ClassicPiece piece)
    {
        int x = piece.x_int;
        int y = piece.y_int;


        if(
			y == 6 && (x >= 0 && x < 4) ||
			y == 6 && (x >= 6 && x < 10) ||
			y == 10 && (x >= 4 && x < 6)
        ){x++;}
        else if (
			y == 4 && (x > 0 && x <= 4) ||
			y == 4 && (x > 6 && x <= 10) ||
			y == 0 && (x > 4 && x <= 6)
        ){x--;}
        else if (
			x == 4 && (y >= 0 && y < 4) ||
			x == 4 && (y >= 6 && y < 10) ||
			x == 0 && (y >= 4 && y < 6)
        ){y++;}
        else if (
                x == 6 && (y > 0 && y <= 4) ||
                        x == 6 && (y > 6 && y <= 10) ||
                        x == 10 && (y > 4 && y <= 6)
        ){y--;}
        else{println("How the fuck did you get here?");}

        piece.x_int = x;
        piece.y_int = y;

    }

}

enum Stage {
    WAITING_TO_ROLL,
    WAITING_TO_PICK_CHOICE,
    WAITING_FOR_ANIMATION_FOR_NEXT_PLAYER
}

enum Team {
    RED,
    BLUE,
    YELLOW,
    GREEN
}

public class Player {
    public ArrayList<ClassicPiece> pieces;
    public TeamEnums team;
    public String name;

    public Player (ArrayList<ClassicPiece> pieces, Team team, String name) {
        this.pieces = pieces;
        this.team = team;
        this.name = name;
    }

    public Player (Team team, String name) {
        this.pieces = new ArrayList<ClassicPiece>();
        this.team = team;
        this.name = name;
    }

    public int nestedPieces(){
        int i=0;
        for (ClassicPiece classicPiece : this.pieces) {
            if(!classicPiece.hasExitedNest)
                i++;
        }
        return i;
    }

    public boolean friendlyPieceAt(int x, int y){
        for (ClassicPiece classicPiece : this.pieces) {
            if(classicPiece.x_int == x && classicPiece.y_int == y)
                return true;
        }
        return false;
    }

    public boolean summonPiece(){
        for (int i=this.pieces.size(); i >= 0; i--) {
        	if(!this.pieces.get(i).hasExitedNest)
        	{
        		int[] spawn_positions = this.fm.getTeamStarterCoords(this.team);
        		this.pieces.get(i).hasExitedNest = true;
        		return true;
        	}
        }
        return false;
    }

    public void addPiece(ClassicPiece piece){this.pieces.add(piece);}

}

public class ClassicPiece {
    public int x_int, y_int;
    public Team team;
    public boolean hasFinished, hasExitedNest;

    public ClassicPiece (Team team) {
        this.team = team;
        this.x_int = -1;
        this.y_int = -1;

        this.hasFinished = false;
        this.hasExitedNest = false;
    }

    public String getName(){return "Classic Piece";}
    public boolean isInTheGame(){return this.hasExitedNest && !this.hasFinished;}

    public void draw(FiaManager fm, int x, int y, int i, color teamColor) {
        fm.drawEllipse(x, y, teamColor);
        FloatVector numberPoint = fm.getPosition(x, y);

        translate(fm.position.x + numberPoint.x, fm.position.y + numberPoint.y);
        textSize(13.9);
        textAlign(CENTER, CENTER);
        fill(color(0));
        text("" + (i + 1), 0, 0);
        translate(-(fm.position.x + numberPoint.x), -(fm.position.y + numberPoint.y));
    }
}
