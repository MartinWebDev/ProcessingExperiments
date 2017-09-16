class GridCell {
    PVector tl;
    PVector tr;
    PVector bl;
    PVector br;
    
    int iIndex;
    int jIndex;
    
    public GridCell(PVector topLeft, PVector topRight, PVector bottomLeft, PVector bottomRight, int i, int j) {
        tl = topLeft;
        tr = topRight;
        bl = bottomLeft;
        br = bottomRight;
        iIndex = i;
        jIndex = j;
    }
}