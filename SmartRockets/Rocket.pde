public class Rocket {
    PVector pos;
    PVector vel;
    PVector acc;
    DNA dna;
    
    float fitness;
    boolean complete;
    boolean dead;
    
    public Rocket(int lifespan) {
        this(new DNA(lifespan));
    }
    
    public Rocket(DNA dna_) {
        pos = new PVector(width / 2, height / 5 * 4);
        vel = new PVector();
        acc = new PVector();
        dna = dna_;
        fitness = 0;
        complete = false;
        dead = false;
    }
    
    public void applyForce(PVector force) {
        acc.add(force);
    }
    
    public void calcFitness(Target target) {
        float d = dist(pos.x, pos.y, target.pos.x, target.pos.y);
        
        //fitness = 1 / d;
        fitness = map(d, 0, width, width, 0);
    }
    
    public void update(int idx) {
        if (complete || dead) return;
        applyForce(dna.genes[idx]);
        
        vel.add(acc);
        pos.add(vel);
        acc.mult(0);
    }
    
    public void completed() {
        complete = true;
    }
    
    public void died() {
        dead = true;
    }
    
    public boolean hitWall(Wall[] walls) {
        for (int i = 0; i < walls.length; i++) {
            Wall w = walls[i];
            if (
                pos.x > w.pos.x - (w.w / 2) && 
                pos.x < w.pos.x + (w.w / 2) && 
                pos.y > w.pos.y - (w.h / 2) &&
                pos.y < w.pos.y + (w.h / 2)
            ) {
                return true;
            }
        }
        
        return false;
    }
    
    public void show() {
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(vel.heading());
        
        rectMode(CENTER);
        noStroke();
        if (dead) fill(255, 0, 0);
        else if (complete) fill(0, 255, 0);
        else fill(255);
        rect(0, 0, 50, 10);
        popMatrix();
    }
}
