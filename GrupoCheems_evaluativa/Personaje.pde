class Personaje extends FBox{
  Boolean visible;
  
  Personaje (float _w, float _h){
    super (_w, _h); 
  }
  
  void inicializarHijo(float _x, float _y){
    visible= true;
    setPosition(_x, _y);
    attachImage(loadImage ("hijo.png"));
    setRotatable(true);
    setRestitution(0.5); //rebotabilidad
    setFriction(2);
    setDensity(3);
    
  }  void inicializarEsposa(float _x, float _y){
    visible= true;
    setPosition(_x, _y);
    attachImage(loadImage ("esposa.png"));
    setRotatable(true);
    setRestitution(0.5); //rebotabilidad
    setFriction(2);
    setDensity(3);
    
  }

  void reboteNormal(){
    setRestitution(0.5); //rebotabilidad
  }
  
  void atrapa(){
    visible=false;
    contador= contador+1;
  }
  
  void electrocutar(){    
    setRestitution(2.5);
    setFriction(0);
  }
  
  void explota(){
    visible=false;
  }
}
