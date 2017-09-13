public class Floor {
    public Floor() {
        
    }
    
    void Render() {
        pushMatrix();
        noStroke();
        fill(127, 0, 255);
        box(1000, 10, 1000);
        popMatrix();
    }
}