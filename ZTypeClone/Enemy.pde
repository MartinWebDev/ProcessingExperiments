class Enemy {
    PVector pos;
    Word word;
    
    public Enemy(float x, float y) {
        pos = new PVector(x, y);
        word = new Word("RANDOM");
    }
    
    void render() {
        pushMatrix();
        // Draw enemy position
        translate(pos.x, pos.y);
        noStroke();
        ellipseMode(CENTER);
        fill(120, 30, 20);
        ellipse(0, 0, 16, 16);
        
        // Draw enemy word
        word.render(new PVector(0, 50));
        popMatrix();
    }
}
