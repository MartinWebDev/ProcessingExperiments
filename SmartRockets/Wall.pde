public class Wall {
    PVector pos;
    float w;
    float h;
    
    public Wall(PVector pos_, float w_, float h_) {
        pos = pos_;
        w = w_;
        h = h_;
    }
    
    public void show() {
        rectMode(CENTER);
        fill(255);
        rect(pos.x, pos.y, w, h);
    }
}
