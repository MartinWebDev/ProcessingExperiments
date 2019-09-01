public class Target {
    PVector pos;
    int d;
    
    public Target(PVector pos_) {
        pos = pos_;
        d = 50;
    }
    
    void show() {
        stroke(255, 0, 0);
        fill(255);
        circle(pos.x, pos.y, d);
        
        fill(255, 0, 0);
        circle(pos.x, pos.y, d / 4 * 3);
        
        fill(255);
        circle(pos.x, pos.y, d / 4 * 2);
        
        fill(255, 0, 0);
        circle(pos.x, pos.y, d / 4);
        noStroke();
    }
}
