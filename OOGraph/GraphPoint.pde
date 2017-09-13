public class GraphPoint {
    java.lang.Integer cValue;
    java.lang.Integer pValue;
    java.lang.Integer nValue;
    
    java.lang.Integer cXPos;
    java.lang.Integer pXPos;
    java.lang.Integer nXPos;

    PVector controlPointAngle;
    float controlPointStrengthPrevious;
    float controlPointStrengthNext;

    public PVector controlPointPrev;
    public PVector controlPointNext;
    
    int magStrength = 30;
    boolean hidePoints = false;
    int hideAlpha = 50;
    int showAlpha = 255;

    public GraphPoint(
        java.lang.Integer value, java.lang.Integer previousValue, java.lang.Integer nextValue, 
        java.lang.Integer xLocation, java.lang.Integer xPrevLocation, java.lang.Integer xNextLocation
    ) {
        cXPos = xLocation;
        pXPos = xPrevLocation;
        nXPos = xNextLocation;
        
        cValue = value;
        pValue = previousValue;
        nValue = nextValue;

        // Initialise control points
        controlPointAngle = new PVector(20, 0);
        controlPointStrengthPrevious = controlPointAngle.mag();
        controlPointStrengthNext = controlPointAngle.mag();

        controlPointPrev = new PVector();
        controlPointNext = new PVector();
    }

    public int CurrentGraphValue() {
        return cValue;
    }

    public void UpdateGraphValue(int newValue) {
        cValue = newValue;
    }

    public void Render(int xLocation) {
        CalculateControlPointValues();
        CalculateControlPoints(xLocation);
        RenderControlPoints(xLocation);

        stroke(255, 255, 0, (hidePoints ? hideAlpha : showAlpha));
        strokeWeight(10);
        point(xLocation, cValue);
    }

    private void CalculateControlPointValues() {
        // Special conditions for first and last
        if (pValue == null) {
            controlPointAngle.x = 1;
            controlPointAngle.y = -1;
        } 
        else if (nValue == null) {
            controlPointAngle.x = 1;
            controlPointAngle.y = 1;
        } 
        else {
            boolean isPreviousLower = pValue < cValue;
            boolean isNextLower = nValue < cValue;

            if ((isPreviousLower && isNextLower) || (!isPreviousLower && !isNextLower)) { // Might need to also say "if previous or next are equal, consider it the same". Test first
                controlPointAngle.x = 1;
                controlPointAngle.y = 0;
                PVector middle = new PVector(1, 0);
                middle.setMag(magStrength);
                controlPointAngle = middle;
            } 
            else {
                controlPointAngle.x = 1;
                controlPointAngle.y = 0;
                CalculateNewControlAngles();
            }
        }
        
        // Get the magnitute. 
        controlPointStrengthPrevious = controlPointAngle.mag();
        controlPointStrengthNext = controlPointAngle.mag();
    }

    private void CalculateNewControlAngles() {
        // TEMP Draw the line so I can see it
        stroke(200, 100, 150, (hidePoints ? hideAlpha : showAlpha));
        strokeWeight(1);
        line(pXPos, pValue, nXPos, nValue);
        
        // The angle of the vector between previous and next is the angle I want to apply to current
        PVector previousVector = new PVector(pXPos, pValue);
        PVector nextVector = new PVector(nXPos, nValue);
        PVector middle = PVector.sub(nextVector, previousVector);
        middle.setMag(magStrength);
        controlPointAngle = middle;
        //middle.normalize();
        //println(middle.heading());
        //float angleInDegrees = middle.heading() * (180 / PI);
        //controlPointAngle.rotate(HALF_PI);
    }

    private void CalculateControlPoints(int xLocation) {
        //// From known angle of vector, do some trigonometry to get new x, and y
        //float hLength = controlPointStrengthNext;// * 30;
        ////float angleInDegrees = controlPointAngle.heading() * (180 / PI);
        //float angleInDegrees = 45;
        //// SOH-CAH-TOA
        //float xAcross = cos(angleInDegrees) * hLength;
        //float yDown = sqrt(sq(hLength) - sq(xAcross));

        //// If the angle is negative then we need to reverse the "up and down" logic
        //if (angleInDegrees < 0) {
        //    controlPointPrev.x = xLocation - xAcross;
        //    controlPointPrev.y = cValue + yDown;

        //    controlPointNext.x = xLocation + xAcross;
        //    controlPointNext.y = cValue - yDown;
        //} 
        //else {
        //    controlPointPrev.x = xLocation - xAcross;
        //    controlPointPrev.y = cValue - yDown;

        //    controlPointNext.x = xLocation + xAcross;
        //    controlPointNext.y = cValue + yDown;
        //}
        
        // TEST TEST TEST TEST
        //if (pValue != null && nValue != null) {
            //PVector previousVector = new PVector(pXPos, pValue); //<>//
            //PVector nextVector = new PVector(nXPos, nValue);
            //PVector middle = PVector.sub(nextVector, previousVector);
            //middle.normalize();
            //middle.setMag(20);
            PVector current = new PVector(cXPos, cValue);
            controlPointPrev = PVector.sub(current, controlPointAngle);
            controlPointNext = PVector.add(current, controlPointAngle);
        //}
    }

    private void RenderControlPoints(int xLocation) {
        // Next control point
        strokeWeight(8);
        stroke(255, 0, 0, (hidePoints ? hideAlpha : showAlpha));
        point(controlPointNext.x, controlPointNext.y);

        // Previous control point
        stroke(0, 255, 0, (hidePoints ? hideAlpha : showAlpha));
        point(controlPointPrev.x, controlPointPrev.y);

        // Lines between points
        stroke(255, 100, (hidePoints ? hideAlpha : showAlpha));
        strokeWeight(1);
        line(xLocation, cValue, controlPointNext.x, controlPointNext.y);
        line(xLocation, cValue, controlPointPrev.x, controlPointPrev.y);
    }
}