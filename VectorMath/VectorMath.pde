void setup () {
    size(800, 400);
}

void draw () {
    background(50);

    PVector v1 = new PVector(300, 100);
    PVector v2 = new PVector(100, 300);
    PVector gap = PVector.sub(v1, v2);
    PVector vM = new PVector(120, 180);
    
    // Draw points
    strokeWeight(10);
    stroke(255);
    point(v1.x, v1.y);
    point(v2.x, v2.y);
    point(vM.x, vM.y);
    
    stroke(255, 0, 0);
    //gap.div(2);
    //gap.normalize();
    //gap.mult(10);
    //gap.setMag(10);
    //point(gap.x, gap.y);
    
    // Write out text values
    stroke(255);
    textSize(18);
    
    text("xy: " + v1.x + "," + v1.y, v1.x + 8, v1.y + 18);
    text("xy: " + v2.x + "," + v2.y, v2.x + 8, v2.y + 18);
    text("xy: " + vM.x + "," + vM.y, vM.x + 8, vM.y + 18);
    
    // Gap vector properties
    text("gx: " + gap.x, 10, 20);
    text("gy: " + gap.y, 10, 40);
    text("gh: " + gap.heading(), 10, 60);
    text("gΘ: " + gap.heading() * (180 / PI), 10, 80);
    
    // Do vector math against the middle vector
    gap.setMag(20);
    PVector leftAnchor = PVector.add(vM, gap);
    PVector rightAnchor = PVector.sub(vM, gap);
    stroke(255, 0, 0);
    point(leftAnchor.x, leftAnchor.y);
    stroke(0, 255, 0);
    point(rightAnchor.x, rightAnchor.y);
}