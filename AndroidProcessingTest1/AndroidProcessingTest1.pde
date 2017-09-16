ArrayList<Particle> parts = new ArrayList<Particle>();

void setup() {
    //size(800, 600);
    fullScreen();
    background(20, 20, 80);
    
    for (int i = 0; i < 2; i++) {
        float x = random(width / 4) + ((width / 2) * 2);
        float y = random(height / 4) + ((height / 4) * 2);
        parts.add(new Particle(x, y, (i * 5) + 1));
    }
}

void draw() {
    stroke(255);
    
    point(width / 2, height / 2);
    
    for (Particle p : parts) {
        p.Update(parts);
        p.Show();
    }
}