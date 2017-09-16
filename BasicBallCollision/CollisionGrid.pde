class CollisionGrid {
    int cols;
    int rows;
    int wid;
    int hei;
    
    ArrayList<GridCell> grid;
    
    public CollisionGrid(int c, int r, int w, int h) {
        // Initialise stuff that might be useful
        cols = c;
        rows = r;
        wid = w;
        hei = h;
        
        // Initialise cells
        int colSize = floor(wid / cols);
        int rowSize = floor(hei / rows);
        
        grid = new ArrayList<GridCell>();
        
        for (int i = 0; i < cols - 1; i++) {
            int colStart = (i * colSize);
            int colEnd = (i * colSize) + colSize;
            
            for (int j = 0; j < rows - 1; j++) {
                int rowStart = (j * rowSize);
                int rowEnd = (j * rowSize) + rowSize;
                
                PVector tl = new PVector(colStart, rowStart);
                PVector tr = new PVector(colEnd, rowStart);
                PVector bl = new PVector(colStart, rowEnd);
                PVector br = new PVector(colEnd, rowEnd);
                
                grid.add(new GridCell(tl, tr, bl, br, i, j));
            }
        }
    }
}