Floor floor;

void setup() {
    size(800, 600, P3D);
    floor = new Floor();
}

void draw() {
    background(50);
    
    // Universal translate for x and y to be screen center
    translate(width / 2, height); // / 2, 0);
    
    // Setup camera
    //camera(0, 0, -100);
    
    lights();
    
    // Draw stuff here
    floor.Render();

    //pushMatrix();
    //translate(100, height / 2, 0);
    //rotateY(cubeSpinY += 0.005);
    //rotateZ(cubeSpinZ += 0.01);
    //noStroke();
    //fill(200, 80, 127);
    //box(100);
    //popMatrix();
    
    //pushMatrix();
    //translate(500, height*0.35, -200);
    //rotateY(ballSpinY += 0.005);
    //rotateZ(ballSpinZ += 0.001);
    //noFill();
    //stroke(255);
    //sphere(280);
    //popMatrix();
}