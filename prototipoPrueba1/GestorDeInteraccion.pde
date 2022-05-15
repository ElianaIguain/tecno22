class GestorDeInteraccion { //me devuelve los valores que necesito --> swipe hacia arriba, abajo,iz y de
//el swipe ocurre en un frame
  Dir_y_Vel mouse; //me devuelve dir y vel del mouse
  boolean seMoviaEnElFrameAnterior; //tengo que preguntar si se movía

  boolean arriba;
  boolean abajo;
  boolean derecha;
  boolean izquierda;

  boolean movGrande;
  boolean movPeque;
  float tiempoGrande;
  float tiempoPeque;


  GestorDeInteraccion() {
    mouse= new Dir_y_Vel();
  }

  void actualizar() {
    mouse.calcularTodo(mouseX, mouseY);//así se la dir y la vel

    movGrande = false;
    movPeque = false;

    tiempoGrande--;
    tiempoPeque--;
    tiempoGrande = constrain(tiempoGrande, 0, 90);
    tiempoPeque = constrain(tiempoPeque, 0, 90);
 
    if (mouse.velocidad()>10) {
      float umbral = 40;
      if (mouse.velocidad()>umbral) {
        tiempoGrande+=10;
        tiempoPeque-=10;
      } else {
        if (tiempoGrande<10) {
          tiempoPeque+=10;
        }
      }
    }
    if (tiempoGrande>55){
     movGrande = true;
    }
    if (tiempoPeque>55){
     movPeque = true;
    }
      


      //-------- que pasa con el mouse en este frame
      boolean seMueveElMouseEnEsteFrame = false;
      float sensibilidad = 35; //lo que es velocidad en ejem de dir y vel
      if (mouse.velocidad()>sensibilidad && mouse.velocidad()<150) {
        seMueveElMouseEnEsteFrame = true;
      }

      arriba = false;
      abajo = false;
      derecha = false;
      izquierda = false;

      if (seMueveElMouseEnEsteFrame &&
        !seMoviaEnElFrameAnterior) { // si se está moviendo en este y en el anterior no...
        //que pasa
        arriba = mouse.direccionY()<-sensibilidad?true:false;//si la dir en Y es menor a -sensibilidad, se mueve hacia arriba, caso contrario hacia abajo
        abajo = mouse.direccionY()>sensibilidad?true:false;
        derecha = mouse.direccionX()>sensibilidad?true:false;
        izquierda = mouse.direccionX()<-sensibilidad?true:false;
      }
      ////-------- dejo listo todo para el siguiente frame
      seMoviaEnElFrameAnterior = seMueveElMouseEnEsteFrame; //para qe ctualice todo en el siguiente frame, el valor de semovia en el frame anterior va a ser igual frame por el que acambos de pasar
    }
  }
