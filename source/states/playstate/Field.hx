package states.playstate;

class Field extends TetrisGroup {

    public function new(width: Int, height: Int): Void {
        super(initEmptyShape(width, height));
    }

    private static function initEmptyShape(width: Int, height: Int): Array<Array<Int>> {
        var shape = new Array<Array<Int>>();
        for (r in 0...height) {
            shape[r] = createEmptyRow(width);
        }
        return shape;
    }

    private static function createEmptyRow(width: Int): Array<Int> {
        var row = new Array<Int>();
        for (c in 0...width) {
            row[c] = 0;
        }
        return row;
    }

    public function merge(t: Tetromino) {
        for (s in t.occupiedSquares) {
            shape[s.row][s.column] = s.value;
        }
        cleanCompletedRows();
        updateBlocks();
    }

    private function cleanCompletedRows(): Void {
        var completed = completedRows();
        if (completed.length > 0) {
            for (row in completed) {
                collapse(row);
            }
        }
    }

    private function completedRows(): Array<Int> {
        var rowIndices = new Array<Int>();
        for (r in 0...height) {
            if (isRowCompleted(shape[r])) {
                rowIndices.push(r);
            }
        }
        return rowIndices;
    }

    private function isRowCompleted(row: Array<Int>): Bool {
        for (c in 0...width) {
            if (row[c] == 0) {
                return false;
            }
        }
        return true;
    }

    private function collapse(row: Int): Void {
        var r = row;
        while (r > 0) {
            shape[r] = shape[r - 1];
            r -= 1;
        }
        shape[0] = createEmptyRow(width);
    }
}