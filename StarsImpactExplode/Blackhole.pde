class Blackhole {
    PVector pos;
    //PVector vel;
    //PVector acc;
    
    float mass;
    
    public Blackhole(int x, int y, float m) {
        pos = new PVector(x, y);
        //vel = PVector.random2D();
        //acc = new PVector(0, 0);
        
        mass = m;
    }
    
    void Update() {
        
    }
    
    void Render() {
        stroke(0);
        strokeWeight(2 * mass);
        point(pos.x, pos.y);
    }
}