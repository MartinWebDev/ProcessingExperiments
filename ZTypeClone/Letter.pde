class Letter {
    String letter;
    public boolean dead;
    
    public Letter(String lett) {
        letter = lett;
    }
    
    void kill() { dead = true; }
    
    void render(PVector pos) {
        pushMatrix();
        translate(pos.x, pos.y);
        if (dead) { 
            fill(200);
            stroke(220);
            strokeWeight(1);
            line(2, -22, 18, 2);
        }
        else { 
            fill(255); 
        }
        text(letter, 0, 0);
        popMatrix();
    }
}
