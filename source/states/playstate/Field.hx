package states.playstate;

class Field extends TetrisGroup {

    public function new(width: Int, height: Int): Void {
        super(initEmptyShape(width, height));
    }

    private static function initEmptyShape(width: Int, height: Int): Array<Array<Int>> {
        var shape = new Array<Array<Int>>();
        for (r in 0...height) {
            var row = new Array<Int>();
            for (c in 0...width) {
                row[c] = 0;
            }
            shape[r] = row;
        }
        return shape;
    }
}