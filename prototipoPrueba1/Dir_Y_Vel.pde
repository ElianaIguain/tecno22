class Dir_y_Vel {
  float posX;
  float posY;
  float prevPosX;
  float prevPosY;
  float miDireccionX;
  float miDireccionY;
  float vel;
  float miDireccionPolar;

  Dir_y_Vel () {
    this.posX=0;
    this.posY=0;
  }

  void calcularTodo (float mi_X, float mi_Y) {
    prevPosX=posX;
    prevPosY=posY;
    posX=mi_X;
    posY=mi_Y;

    miDireccionX = posX-prevPosX;
    miDireccionY = posY-prevPosY;
    miDireccionPolar = degrees(atan2( posY-prevPosY, posX-prevPosX ));

    vel = dist (posX, posY, prevPosX, prevPosY);
  }


//////* ESTOS SON LOS METODOS QUE DEVUELVEN ALGO *///////

  float velocidad() {
    return vel;
  }

  float direccionX () {
    return miDireccionX;
  }

  float direccionY () {
    return miDireccionY;
  }


  float direccionPolar () {
    return miDireccionPolar;
  }
  
  
//////* ESTO ES PARA DEBBUGGEAR LO QUE SE ESTA VIENDO *///////

  void mostrarData() { 
    textSize(24);
    text ("Velocidad: "+vel, 50, 50);
    text ("Direccion X: "+miDireccionX, 50, 75);
    text ("Direccion Y: "+miDireccionY, 50, 100);
    text ("Direccion Polar: "+miDireccionPolar, 50, 125);

    pushMatrix();
    pushStyle();
    noFill();
    stroke(255);
    strokeWeight(3);
    translate (width/2, height/2);

    ellipse (0, 0, 100, 100);
    rotate (radians(miDireccionPolar));
    line (0, 0, vel*2, 0);

    popMatrix();
    popStyle();
  }  

  ///////////// FIN  ///////
}
