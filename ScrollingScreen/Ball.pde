class Ball {
    PVector pos;
    int r;
    
    public Ball(int x, int y, int radius) {
        pos = new PVector(x, y);
        r = radius;
    }
    
    void Update() {
        PVector addme = new PVector(5, 5);
        pos.add(addme);
    }
    
    void Render() {
        pushMatrix();
        translate(pos.x, pos.y);
        noStroke();
        fill(255);
        ellipse(0, 0, r*2, r*2);
        popMatrix();
    }
}