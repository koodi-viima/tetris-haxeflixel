package states;
import flixel.FlxState;
import flixel.FlxG;
import states.playstate.Tetris;

class PlayState extends FlxState {

    var tetris: Tetris;

    override public function create(): Void {
        super.create();
        tetris = new Tetris(10, 20);
        add(tetris);
    }

    override public function update(elapsed: Float) {
        super.update(elapsed);
        if (tetris.isGameOver) {
            FlxG.switchState(new GameOverState());
        }
    }
}
