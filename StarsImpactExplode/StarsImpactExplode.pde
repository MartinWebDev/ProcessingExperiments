Blackhole[] bhs = new Blackhole[1];
ArrayList<Explosion> expl = new ArrayList<Explosion>();
Star[] stars = new Star[10];

void setup() {
    size(1080, 640);
    background(50);
    
    for (int i = 0; i < stars.length; i++) {
        stars[i] = new Star(floor(random(width)), floor(random(height)), random(5));
    }
    
    for (int i = 0; i < bhs.length; i++) {
        bhs[i] = new Blackhole(width / 2, height / 2, 5);
    }
}

void draw() {
    background(50);
    
    fill(220);
    noStroke();
    textAlign(LEFT, TOP);
    text("FPS: " + frameRate, 10, 10);
    
    // Update explosions
    for (int i = expl.size() - 1; i >= 0; i--) {
        Explosion exp = expl.get(i);
        exp.Update();
        exp.Render();
        
        if (exp.IsFinished()) {
            expl.remove(i);
        }
    }
    
    // Update and draw stars
    for (int i = 0; i < stars.length; i++) {
        // Do collision detection here. 
        Collisions();
        // If 2 stars collide, kill the stars, and replace with an explosion. 
        // An explosion will spread from the point of impact to a certain size, as each star intersects this explosion radius it is subjected to a repulsion force
        // The biggest the distance the weaker the force
        
        // If a star is at the end of its life, replace it with a new one
        if (stars[i].IsDead()) {
            stars[i] = new Star(floor(random(width)), floor(random(height)), random(1, 2));
        }
        
        stars[i].Update(bhs, stars, expl);
        stars[i].Render();
        fill(200);
        text(i, stars[i].pos.x + 3, stars[i].pos.y - 3);
    }
    
    // Draw blackholes
    for (int i = 0; i < bhs.length; i++) {
        bhs[i].Render();
    }
}

void Collisions() {
    for (int i = 0; i < stars.length - 1; i++) {
        for (int j = i + 1; j < stars.length; j++) {
            if (i != j && stars[i].CollidedWith(stars[j])) {
                //println("Bang! " + i + "-" + j);
                stars[i].Kill();
                stars[j].Kill();
                
                // Find mid point between stars and set explosion there
                PVector mid = PVector.sub(stars[i].pos, stars[j].pos);
                mid.div(2);
                PVector explosion = PVector.add(stars[i].pos, mid);
                expl.add(new Explosion(floor(explosion.x), floor(explosion.y)));
                
                //i = stars.length;
                j = stars.length;
            }
        }
    }
}