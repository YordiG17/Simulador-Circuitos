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
  int rad;                    //Radio de Selección
  float ult_x, ult_y;         //Último click presionado
  
  //Visualización previa
    Componente comp_temp;
  
  public Interfaz () {
    this.creador = new Creador_circuitos ();
    this.selector = new Selector ();
    this.motor = new Motor_grafico (5000, 5000);
    this.rad = 100;
  }
  
  
  //----------------------------|Mostrar Area Trabajo|----------------------------//
  public void mostrarAreaTrabajo () {
    this.mostrarTabla();
    creador.modificar(motor.rt_x, motor.rt_y, this.rad, this.selector);
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
  public void detectarSeleccion (float ratonX, float ratonY, Circuito circuito) {
    motor.actualizarRaton(ratonX, ratonY);
    selector.detectarSeleccion(motor.rt_x, motor.rt_y, this.rad, circuito);
    
    //Detectar Nodos
    if (selector.nodo_slc != null) {
      println("Nodo detectado: " + selector.nodo_slc.obtenerNombre());
      selector.nodo_slc.mostrarAreaSeleccion(this.rad, motor);
      return;
    }
    
    //Si no detecta ni Nodos ni Ramales
    if (selector.ramal_slc == null) {
      println("Sin contacto");
      return;
    }
        
    //Detectar Componentes
    if (selector.comp_slc != null) {
      int[] x = new int[] {selector.ramal_slc.obtenerNodo1().obtenerPosX(),selector.ramal_slc.obtenerNodo2().obtenerPosX()};
      int[] y = new int[] {selector.ramal_slc.obtenerNodo1().obtenerPosY(), selector.ramal_slc.obtenerNodo2().obtenerPosY()};
      selector.comp_slc.mostrarAreaSeleccion(x, y, this.rad, motor);
      println("Componente detectado");
      return;
    }
    
    //Detectar Ramales
    println("Ramal detectado: " +selector.ramal_slc.obtenerNombre());
    selector.ramal_slc.mostrarAreaSeleccion(this.rad, motor);
      
    float x1 =  selector.ramal_slc.obtenerNodo1().obtenerPosX();
    float y1 =  selector.ramal_slc.obtenerNodo1().obtenerPosY();
    float x2 =  selector.ramal_slc.obtenerNodo2().obtenerPosX();
    float y2 =  selector.ramal_slc.obtenerNodo2().obtenerPosY();
    float[] punto = Calculadora_geo.puntoPerpendicular(motor.rt_x, motor.rt_y, x1, y1, x2, y2);
    motor.mostrarLinea(motor.rt_x, motor.rt_y, punto[0], punto[1]);
  }
  
  //----------------------------|Mostrar Vista Previa|----------------------------//
  public void mostrarVistaPrevia (float ratonX, float ratonY, Circuito circuito) {
    motor.actualizarRaton(ratonX, ratonY);
    selector.detectarSeleccion(motor.rt_x, motor.rt_y, this.rad, circuito);
    
    if (creador.obtenerModo().equals("Resistor")) {
      //Si no hay ramal seleccionado
      if (selector.ramal_slc == null) {
        this.comp_temp.mostrarSueltoBloq(motor.rt_x, motor.rt_y, motor);
        return;
      }
        
      int pos = Math.round(selector.ramal_slc.calcularPosComponente(motor.rt_x, motor.rt_y));
      
      if (creador.validarColocacionComponente (ratonX, ratonY, rad, selector, selector.ramal_slc)) {
        int[] x = new int[] {selector.ramal_slc.nodo1.obtenerPosX(), selector.ramal_slc.nodo2.obtenerPosX()};
        int[] y = new int[] {selector.ramal_slc.nodo1.obtenerPosY(), selector.ramal_slc.nodo2.obtenerPosY()};
        this.comp_temp.modificarPos(pos);
        this.comp_temp.mostrar(x, y, motor);
      }
      
      return;
    }
    
    if (creador.obtenerModo().equals("Cable")) {
      motor.mostrarLinea(motor.rt_x, motor.rt_y, this.ult_x, this.ult_y);
      return;
    }
    
  }
  
  //----------------------------|Armar Circuito|----------------------------//
  public void armarCircuito (float ratonX, float ratonY, Circuito circuito) {
    presionar(ratonX, ratonY);
    creador.accionar(motor.rt_x, motor.rt_y, this.rad, circuito, this.selector);
  }
  
  //----------------------------|Presionar Interfaz|----------------------------//
  public void presionar (float ratonX, float ratonY) {
    motor.actualizarRaton(ratonX, ratonY);
    this.ult_x = motor.rt_x;
    this.ult_y = motor.rt_y;
  }
  
  //----------------------------|Seleccionar Modo|----------------------------//
  public void seleccionarModo (char tecla) {
    if (tecla == 's')
      creador.modoSeleccion(true);
    if (tecla == 'c')
      creador.modoCables(true);
    if (tecla == 'q')
      creador.desactivarModos();
    if (tecla == 'e')
      creador.modoEliminacion(true);
    if (tecla == 'r') {
      creador.modoResistor (true, 0);
      this.comp_temp = new Resistor (1, 1);
    }
    if (tecla == 'f') {
      creador.modoFuente (true, 0);
      this.comp_temp = new Fuente (1, 1, creador.obtenerOrientacion());
    }
  }
}
