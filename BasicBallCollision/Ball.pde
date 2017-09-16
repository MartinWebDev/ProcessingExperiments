class Ball {
    PVector loc;
    PVector vel;
    
    int radius;
    
    color fillColor;
    color strokeColor;
    
    public Ball(int x, int y, int r) {
        loc = new PVector(x, y);
        vel = PVector.random2D();
        
        radius = r;
        
        strokeColor = color(127, 127, 127);
        fillColor = color(200, 200, 200);
    }
    
    void Update() {
        loc.add(vel);
        Bounds();
    }
    
    void Bounds() {
        if (loc.x - radius > width)
            loc.x = 0 - radius;
        if (loc.x + radius < 0)
            loc.x = width + radius;
        if (loc.y - radius > height)
            loc.y = 0 - radius;
        if (loc.y + radius < 0)
            loc.y = height + radius;
    }
    
    boolean DidCollide(Ball b) {
        // Can easily calculate if 2 circles collide by checking if their distance is less than or equal to the sum of their radiuses
        PVector gap = PVector.sub(loc, b.loc);
        int dist = floor(gap.mag());
        
        if (dist < (radius + b.radius))
            return true;
        
        return false;
    }
    
    void Collision(boolean didCollide) {
        if (didCollide)
            strokeColor = color(255, 0, 0);
        else
            strokeColor = color(127, 127, 127);
    }
    
    void Repel(PVector forceVector) {
        vel = forceVector;
    }
    
    void Render() {
        fill(fillColor);
        stroke(strokeColor);
        strokeWeight(3);
        ellipse(loc.x, loc.y, radius * 2, radius * 2);
    }
}