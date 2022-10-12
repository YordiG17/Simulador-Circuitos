/*
|====================================================================|
*                             |Interfaz|         
* Descripción:                                                        
*   Clase utilizada para 
|====================================================================|
*/

public class Interfaz {
  
  Creador_circuitos creador;  //Objeto encargador de crear los circuitos
  Selector selector;          //Objeto que selecciona componentes del circuito
  Motor_grafico motor;        //Objeto que visualiza el área de trabajo de la interfaz
  int rad;                    
  
  public Interfaz () {
    this.creador = new Creador_circuitos ();
    this.selector = new Selector ();
    this.motor = new Motor_grafico (5000, 5000);
    this.rad = 100;
  }
  
  
  //----------------------------|Mostrar Area Trabajo|----------------------------//
  public void mostrarAreaTrabajo () {
    this.mostrarTabla();
    creador.modificar(motor.rt_x, motor.rt_y);
  }
  
  //----------------------------|Mostrar Tabla de Dibujo|----------------------------//
  public void mostrarTabla () {
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        motor.mostrar("tabla", 500 * i, 500 * j, 500, 500);
      }
    }
  }
  
  //----------------------------|Analizar Detecciones|----------------------------//
  public void detectarSeleccion (float ratonX, float ratonY, int rad, Circuito circuito) {
    motor.actualizarRaton(ratonX, ratonY);
    selector.detectarSeleccion(motor.rt_x, motor.rt_y, rad, circuito);
    
    //Detectar Nodos
    if (selector.nodo_slc != null) {
      println("Nodo detectado: " + selector.nodo_slc.obtenerNombre());
      selector.nodo_slc.mostrarAreaSeleccion(rad, motor);
      return;
    }
    
    //Detectar Ramales
    if (selector.ramal_slc != null) {
      println("Ramal detectado: " +selector.ramal_slc.obtenerNombre());
      selector.ramal_slc.mostrarAreaSeleccion(rad, motor);
      
      float x1 =  selector.ramal_slc.obtenerNodo1().obtenerPosX();
      float y1 =  selector.ramal_slc.obtenerNodo1().obtenerPosY();
      float x2 =  selector.ramal_slc.obtenerNodo2().obtenerPosX();
      float y2 =  selector.ramal_slc.obtenerNodo2().obtenerPosY();
      float[] punto = Calculadora_geo.puntoTriangular(motor.rt_x, motor.rt_y, x1, y1, x2, y2);
      motor.mostrarLinea(motor.rt_x, motor.rt_y, punto[0], punto[1]);
      return;
    }
    
    println("Sin contacto");
  }
  
  //----------------------------|Armar Circuito|----------------------------//
  public void armarCircuito (float ratonX, float ratonY, Circuito circuito) {
    motor.actualizarRaton(ratonX, ratonY);
    creador.accionar(motor.rt_x, motor.rt_y, this.rad, circuito, this.selector);
  }
  
  //----------------------------|Seleccionar Modo|----------------------------//
  public void seleccionarModo (char tecla) {
    if (tecla == 's')
      creador.modoSeleccion(true);
    if (tecla == 'c')
      creador.modoCables(true);
    if (tecla == 'r')
      creador.modoResistor (true, 0);
    if (tecla == 'f')
      creador.modoFuente (true, 0);
    if (tecla == 'q')
      creador.desactivarModos();
    if (tecla == 'e')
      creador.modoEliminacion(true);
  }
}
