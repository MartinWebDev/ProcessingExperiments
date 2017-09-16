// Basic ball collision and bounce
Ball[] balls = new Ball[100];
CollisionGrid grid;

long collisionRunTime = 0;
long collisionRunCount = 0;
long collisionRunTotalTime = 0;
long collisionAverageRunTime = 0;

// TODO: Eventually I will divide the screen into chunks and optimise the collision detection, but I will draw the lines now.
int rows = 10;
int cols = 10;
int rowSize;
int colSize;

void setup() {
    size(800, 600);
    
    // Determine how far apart the dividing lines are
    colSize = floor(width / cols);
    rowSize = floor(height / rows);
    
    for (int i = 0; i < balls.length; i++) {
        balls[i] = new Ball(floor(random(width)), floor(random(height)), floor(random(10, 20)));
    }
    
    grid = new CollisionGrid(cols, rows, width, height);
}

void draw() {
    //Reset background
    background(50);
    
    // Draw section lines
    stroke(100);
    strokeWeight(1);
    
    for (int i = 0; i < cols - 1; i++) {
        int xPos = (i * colSize) + colSize;
        line(xPos, 0, xPos, height);
    }
    for (int i = 0; i < rows - 1; i++) {
        int yPos = (i * rowSize) + rowSize;
        line(0, yPos, width, yPos);
    }
    
    // Framerate
    noStroke();
    fill(80, 200, 50);
    textSize(18);
    textAlign(LEFT, TOP);
    text("FPS: " + floor(frameRate * 100) / 100, 10, 10);
    
    // Collision detection
    long lStartTime = System.nanoTime();
    DetectCollisions();
    //DetectAllCollisions();
    long lEndTime = System.nanoTime();
    long output = lEndTime - lStartTime;
    collisionRunTime = output / 1000000;
    collisionRunTotalTime += collisionRunTime;
    collisionRunCount++;
    collisionAverageRunTime = collisionRunTotalTime / collisionRunCount;
    
    // Note the time taken
    //println("Average time taken to run collision detection: " + collisionRunTotalTime / collisionRunCount);
    
    // Draw balls
    for (Ball b : balls) {
        b.Update();
        b.Render();
    }
    
    // Average collision time
    fill(255, 0, 0);
    text("AVG: " + collisionAverageRunTime, 10, 40);
}

void AddRepulsion(int i, int j) {
    // TODO This calculation is not correct. 
    // It should be based on the previous position of each ball, and calculate the angle of IMPACT not the angle of difference as it currently does
    // Calculate repulsion force for each colliding pair
    PVector repel1 = PVector.sub(balls[i].loc, balls[j].loc);
    repel1.normalize();
    PVector repel2 = PVector.mult(repel1, -1);
    
    balls[i].Repel(repel1);
    balls[j].Repel(repel2);
}

void DetectCollisionsByGrid() {
    // TODO: This version will be much more complex. Instead of checking every ball against every other ball, 
    // it will actually use the grid lines to locate all the balls, and only test each ball against other balls within the same grid cell
    // Do not forget that a ball can appears in multiple cells at once, so will need to check every ball in every cell that ball occupies. 
}

void DetectAllCollisions() {
    // Collision detection
    for (int i = 0; i < balls.length; i++) {
        // For each ball, check collision with each ball after it in the array, and calculate + apply repel force if they do.
        for (int j = 0; j < balls.length; j++) {
            if (i != j) {
                boolean collision = balls[i].DidCollide(balls[j]);
                
                if (collision) {
                    balls[i].Collision(true);
                    balls[j].Collision(true);
                    
                    // Code separated from this loop so it can be reused
                    AddRepulsion(i, j);
                    
                    // Use this as a way to break from BOTH loops. break; will only do the current loop
                    //i = balls.length;
                    //j = balls.length;
                }
                else {
                    balls[i].Collision(false);
                    balls[j].Collision(false);
                }
            }
        }
    }
}

void DetectCollisions() {
    // Collision detection
    for (int i = 0; i < balls.length - 1; i++) {
        // For each ball, check collision with each ball after it in the array, and calculate + apply repel force if they do.
        for (int j = i + 1; j < balls.length; j++) {
            boolean collision = balls[i].DidCollide(balls[j]);
            
            if (collision) {
                balls[i].Collision(true);
                balls[j].Collision(true);
                
                AddRepulsion(i, j);
                
                // Use this as a way to break from BOTH loops. break; will do the current
                //i = balls.length;
                //j = balls.length;
            }
            else {
                balls[i].Collision(false);
                balls[j].Collision(false);
            }
        }
    }
}