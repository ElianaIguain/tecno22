class Plataforma extends FBox
{
  Boolean j;
  Plataforma(float _w, float _h)
  {
    super(_w, _h);
  }

  void inicializar(float _x, float _y, Boolean _piso, Boolean _nubeGris)
  {
    setName("plataforma");
    setPosition(_x, _y);
    setStatic( true );
    setGrabbable(false);
    j = false;

    if (!_piso) {
      attachImage(loadImage ("nube.png"));
    }
    if (!_nubeGris) {
      attachImage(loadImage ("nubeGris.png"));
    }
  }
  void girar() {
    if (j) {
      setRotation( radians(frameCount));
    }
  }
  void rebote(){
     setRestitution(0.5); //rebotabilidad
  }
}
