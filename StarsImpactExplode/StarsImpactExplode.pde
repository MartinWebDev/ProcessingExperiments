Blackhole[] bhs = new Blackhole[1];
//Explosion[] expl = new Explosion[1];
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
    //background(50);
    
    // Update and draw stars
    for (int i = 0; i < stars.length; i++) {
        // Do collision detection here. 
        // If 2 stars collide, kill the stars, and replace with an explosion. 
        // An explosion will spread from the point of impact to a certain size, as each star intersects this explosion radius it is subjected to a repulsion force
        // The biggest the distance the weaker the force
        
        // If a star is at the end of its life, replace it with a new one
        if (stars[i].IsDead()) {
            stars[i] = new Star(floor(random(width)), floor(random(height)), random(1, 2));
        }
        
        stars[i].Update(bhs, stars);
        stars[i].Render();
    }
    
    // Draw blackholes
    for (int i = 0; i < bhs.length; i++) {
        bhs[i].Render();
    }
}