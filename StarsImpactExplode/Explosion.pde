class Explosion {
    PVector pos;
    int r;
    
    int life;
    
    public Explosion(int x, int y) {
        pos = new PVector(x, y);
        r = 1;
        life = 100;
    }
    
    boolean IsFinished() {
        return life <= 0;
    }
    
    void Update() {
        r++;
        life --;
    }
    
    void Render() {
        
    }
}