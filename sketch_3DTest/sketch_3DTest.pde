float x, y, z;
float cubeSpinY = 0.0;
float cubeSpinZ = 0.0;
float ballSpinY = 0.0;
float ballSpinZ = 0.0;

void setup() {
    size(800, 600, P3D);
    
    x = width / 2;
    y = height / 2;
    z = 0;
}

void draw() {
    background(50);
    
    lights();

    pushMatrix();
    translate(100, height / 2, 0);
    rotateY(cubeSpinY += 0.005);
    rotateZ(cubeSpinZ += 0.01);
    noStroke();
    fill(200, 80, 127);
    box(100);
    popMatrix();
    
    pushMatrix();
    translate(500, height*0.35, -200);
    rotateY(ballSpinY += 0.005);
    rotateZ(ballSpinZ += 0.001);
    noFill();
    stroke(255);
    sphere(280);
    popMatrix();
}