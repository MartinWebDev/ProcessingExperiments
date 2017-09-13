ArrayList<Particle> parts = new ArrayList<Particle>();

void setup() {
    size(800, 600);
    background(20, 20, 80);
    
    for (int i = 0; i < 2; i++) {
        //parts.add(new Particle(random(width), random(height), (i * 5) + 1));
        float x = random(width / 6) + ((width / 6) * 3);
        float y = random(height / 6) + ((height / 6) * 3);
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