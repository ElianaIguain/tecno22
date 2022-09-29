class Tiempo {

  float medida;

  Tiempo() {
    medida = 3;
  }

  void dibujar() {

    //recuadro
    pushStyle();
    noFill();
    rect(20, 20, temporizadorParaDibujo/medida, 30); 
    popStyle();
    
    //fondo transparente
    pushStyle();
    fill(0,0,0,50);
    rect(20, 20, temporizadorParaDibujo/medida, 30); 
    popStyle();

    //relleno
    pushStyle();
    if (temporizador>=temporizadorParaDibujo/2) {
      fill(53, 255, 139);//verde
    } else if (temporizador<temporizadorParaDibujo/2 && temporizador>= temporizadorParaDibujo/4) {
      fill(255, 245, 123);//amarillo
    } else {
      fill(255, 49, 102);//rojo
    }
    noStroke();
    rect(21, 21, temporizador/medida, 29); 
    popStyle();
  }
}
