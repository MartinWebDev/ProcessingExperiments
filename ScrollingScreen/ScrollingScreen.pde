int screenWidth = 800;
int screenHeight = 600;

int gameWidth = 1000;
int gameHeight = 1000;

int globalOffsetX = 0;
int globalOffsetY = 0;

int wallThickness = 50;

Ball ball1;
Ball bodyToTrack;

void settings() {
    size(gameWidth > screenWidth ? screenWidth : gameWidth, gameHeight > screenHeight ? screenHeight : gameHeight);
}

void setup() {
    ball1 = new Ball(50, 50, 10);
    bodyToTrack = ball1;
}

void draw() {
    background(50);
    
    // Anything that should be static to the screen shuold be drawn here, before the global offset calculation
    DrawFramerate();
    
    // Calculate the global offset based on the body we want to track
    GlobalOffset();
    
    // Anything else to draw goes below the offset
    DrawBoundaries();
    
    // Updates
    ball1.Update();
    
    // Render
    ball1.Render();
}

void GlobalOffset() {
    if (bodyToTrack.pos.x > width / 2) {
        globalOffsetX = floor(0 - bodyToTrack.pos.x + width / 2); // 0 = origin point
    }
    if (bodyToTrack.pos.y > height / 2) {
        globalOffsetY = floor(0 - bodyToTrack.pos.y + height / 2); // 0 = origin point
    }
    globalOffsetX = constrain(globalOffsetX, -(gameWidth - width), 0);
    globalOffsetY = constrain(globalOffsetY, -(gameHeight - height), 0);
    translate(globalOffsetX, globalOffsetY);
}

void DrawFramerate() {
    noStroke();
    fill(255);
    textSize(18);
    textAlign(LEFT, TOP);
    text("FPS: " + (float)floor(frameRate * 100) / 100, 5, 5);
}

void DrawBoundaries() {
    //noStroke();
    //fill(200);
    noFill();
    stroke(255, 255, 255, 200);
    strokeWeight(4);
    rectMode(CORNER);
    // Upper
    rect(0, 0, gameWidth, wallThickness);
    // Lower
    rect(0, gameHeight - wallThickness, gameWidth, wallThickness);
    // Left
    rect(0, 0, wallThickness, gameHeight);
    // Right
    rect(gameWidth - wallThickness, 0, gameWidth - wallThickness, gameHeight); 
}