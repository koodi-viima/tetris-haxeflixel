package;

import flixel.FlxGame;
import openfl.display.Sprite;
import states.MainMenuState;
import states.PlayState;

class Main extends Sprite {
    public function new() {
        super();
        addChild(new FlxGame(320, 640, MainMenuState, 1, 60, 60, true));
    }
}
