// Graph render test

// Axis liens
int xAxisStartX = 10;
int xAxisStartY = 500;
int xAxisLength = 500;

int yAxisStartX = 10;
int yAxisStartY = 500;
int yAxisLength = 300;

// Graph points
//PVector startLoc = new PVector(100, 100);
//PVector midLoc = new PVector(200, 300);
//PVector endLoc = new PVector(300, 250);

PVector startLoc = new PVector(100, 100);
PVector midLoc = new PVector(200, 120);
PVector endLoc = new PVector(300, 250);

// Control points for bezier curves
PVector line1Control1 = new PVector(150, startLoc.y);
PVector line1Control2 = new PVector(150, midLoc.y);
PVector line2Control1 = new PVector(250, midLoc.y);
PVector line2Control2 = new PVector(250, endLoc.y);

// Random noise test
float xOffsetNoise = 0;

void setup() {
    size(800, 600);
}

void draw() {
    // Update control points to match graph points noise
    line1Control1.y = startLoc.y;
    line1Control2.y = midLoc.y;
    line2Control1.y = midLoc.y;
    line2Control2.y = endLoc.y;
    
    background(50);
    
    // Draw axis lines
    stroke(255);
    strokeWeight(2);
    line(xAxisStartX, xAxisStartY, xAxisStartX + xAxisLength, xAxisStartY);
    line(yAxisStartX, yAxisStartY, yAxisStartX, yAxisStartY - yAxisLength);
    
    // Translate to axis 0, 0
    translate(10, 500);
    
    // Line between previous and next points from center
    stroke(120);
    line(startLoc.x, -startLoc.y, endLoc.x, -endLoc.y);
    PVector disDir = PVector.sub(endLoc, startLoc);
    float mag = disDir.mag();
    
    pushMatrix();
    translate(startLoc.x, -startLoc.y);
    rotate(-disDir.heading());
    strokeWeight(10);
    point(mag / 2, 0);
    strokeWeight(1);
    line(mag / 2, 0, mag / 2, -100);
    popMatrix();
    
    // Draw lines between graph points and control points
    stroke(100);
    strokeWeight(1);
    line(startLoc.x, -startLoc.y, line1Control1.x, -line1Control1.y);
    line(midLoc.x, -midLoc.y, line1Control2.x, -line1Control2.y);
    line(midLoc.x, -midLoc.y, line2Control1.x, -line2Control1.y);
    line(endLoc.x, -endLoc.y, line2Control2.x, -line2Control2.y);
    
    // Draw control points
    stroke(200);
    strokeWeight(6);
    point(line1Control1.x, -line1Control1.y);
    point(line1Control2.x, -line1Control2.y);
    point(line2Control1.x, -line2Control1.y);
    point(line2Control2.x, -line2Control2.y);
    
    // Draw graph points
    stroke(200);
    strokeWeight(10);
    point(startLoc.x, -startLoc.y);
    point(midLoc.x, -midLoc.y);
    point(endLoc.x, -endLoc.y);
    
    // Draw lines between
    stroke(255);
    strokeWeight(2);
    noFill();
    bezier(
        startLoc.x, -startLoc.y, 
        line1Control1.x, -line1Control1.y, 
        line1Control2.x, -line1Control2.y, 
        midLoc.x, -midLoc.y
    );
    
    bezier(
        midLoc.x, -midLoc.y, 
        line2Control1.x, -line2Control1.y, 
        line2Control2.x, -line2Control2.y, 
        endLoc.x, -endLoc.y
    );
    
    // Since lots of things are drawn before the graph points, then add the noise end the end of the loop, not the start
    startLoc.y += (noise(xOffsetNoise) - 0.5) * 1;
    midLoc.y += (noise(xOffsetNoise + 1000) - 0.5) * 1;
    endLoc.y += (noise(xOffsetNoise + 10000) - 0.5) * 1;
    xOffsetNoise += 0.01;
}