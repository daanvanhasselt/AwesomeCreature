class AwesomeCreature extends Creature {

  float lastFrameTime = 0;
  float time = 0;
  float speed = 1;
  
  float globalRotation = 0;

  AwesomeCreature(float x, float y)
  {
    super(x,y);
  }

  //----------------------------------------

  void draw(float x, float y)
  {
    speed = map(pow(agitation, 8), 0, 1, 1, 4);
    updateTime();
    
    globalRotation += map(speed, 1, 10, 0.015, 0.1);

    pushMatrix();
    translate(x, y);

    for(float s = 1.5; s > 0.25; s -= 0.1) {
      drawCircles(s, globalRotation * map(s, 1.5, 0.25, 1.0, -1.0), 350, map(s, 1.5, 0.25, 0, PI));
    }

    popMatrix();
  }

  //----------------------------------------

  void updateTime() {
    float dT = millis() - lastFrameTime;
    lastFrameTime = millis();
    time += dT * speed;
  }

  //----------------------------------------

  float sinOfTime(float timeScale, float minOut, float maxOut) {
    return sinOfTime(timeScale, minOut, maxOut, 0);
  }
  
  float sinOfTime(float timeScale, float minOut, float maxOut, float offsetPhase) {
    return map(sin((time / timeScale) + offsetPhase), -1, 1, minOut, maxOut);
  } 

  //----------------------------------------

  void drawCircles(float radius, float rotation, float pulseTimeScale, float pulseOffset) {
    pushMatrix();
    rotate(rotation);
    
    radius *= sinOfTime(500, 100, 175, 1.0);
    
    int numberOfCircles = 10;
    for (int i = 0; i < numberOfCircles; i++) {
      float phase = map(i, 0, numberOfCircles, 0, TWO_PI);
      float x = cos(phase) * radius;
      float y = sin(phase) * radius;
      stroke(255);
      strokeWeight(2);
      noFill();

      float s = sinOfTime(500, 0, 1, phase * 3);
      s *= sinOfTime(pulseTimeScale, 0.1, 1, pulseOffset);
      if(s == 0) {
        continue;
      }
      
      pushMatrix();
      float w = 30;
      float h = 30;

      translate(x, y);
      scale(s);
      rotate(phase);
      ellipse(0, 0, w, h);
      popMatrix();
    }
    popMatrix();
  }
};