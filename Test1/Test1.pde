ArrayList<Particle> parts = new ArrayList<Particle>();
//Particle[] p = new Particle[1];

void setup() {
    size(800, 600);
    background(20, 20, 80);
    
    for (int i = 0; i < 2; i++) {
        parts.add(new Particle(random(width), random(height)));
    }
}

void draw() {
    //background(20, 20, 80);
    stroke(255);
    
    //for (int i = 0; i < p.length; i++) {
    for (Particle p : parts) {
        p.Update();
        p.Show();
    }
}