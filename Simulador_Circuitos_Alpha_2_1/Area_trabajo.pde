/*
|====================================================================|
*                        |Área de Trabajo|         
* Descripción:                                                        
*   Clase utilizada para la gestión de todas las clases encargadas
*   del tratamiento del circuito, de igual manera, se encarga
*   de organizar las entradas y la interfaz para el usuario
|====================================================================|
*/

public class Area_trabajo {
  
  //Clases Obreras
    private Creador_circuitos creador;  //Objeto encargador de crear los circuitos
    private Selector selector;          //Objeto que selecciona componentes del circuito
    public Motor_grafico motor;         //Objeto que visualiza el área de trabajo de la interfaz
    
  //Variables de Registro
    private int rad;                    //Radio de Selección
    private float ult_x, ult_y;         //Último click presionado
  
  //Visualización previa
    private Componente comp_temp;       //Componente de Vista Previa, sin función útil
    private int cont = 0;               //Contado de clicks
  
  
  
  public Area_trabajo () {
    this.creador = new Creador_circuitos ();
    this.selector = new Selector ();
    this.motor = new Motor_grafico (5000, 5000);
    this.rad = 100;
    this.comp_temp = new Componente (1, 1, "");
  }
  
  
  //---------------------------------------------------------------------------\\
  //                          |Interfaz del Circuito|                          \\
  //---------------------------------------------------------------------------\\  
  
  //----------------------------|Mostrar Area Trabajo|----------------------------\\
  public void mostrarAreaTrabajo (Circuito circuito) {
    this.mostrarTabla();
    creador.modificar(motor.rt_x, motor.rt_y, this.rad, this.selector);
    circuito.visualizar(motor);
  }
  
  //----------------------------|Mostrar Tabla de Dibujo|----------------------------\\
  public void mostrarTabla () {
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        motor.mostrar("tabla", 500 * i, 500 * j, 500, 500);
      }
    }
  }
  
  //----------------------------|Analizar Detecciones|----------------------------\\
  public void detectarSeleccion (float ratonX, float ratonY, Circuito circuito) {
    motor.actualizarRaton(ratonX, ratonY);
    selector.detectarSeleccion(motor.rt_x, motor.rt_y, this.rad, circuito);
    
    //Detectar Nodos
    if (selector.nodo_slc != null) {
      //println("Nodo detectado: " + selector.nodo_slc.obtenerNombre());
      selector.nodo_slc.mostrarAreaSeleccion(this.rad, motor);
      return;
    }
    
    //Si no detecta ni Nodos ni Ramales
    if (selector.ramal_slc == null) {
      //println("Sin contacto");
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
    //println("Ramal detectado: " +selector.ramal_slc.obtenerNombre());
    selector.ramal_slc.mostrarAreaSeleccion(this.rad, motor);
      
    float x1 =  selector.ramal_slc.obtenerNodo1().obtenerPosX();
    float y1 =  selector.ramal_slc.obtenerNodo1().obtenerPosY();
    float x2 =  selector.ramal_slc.obtenerNodo2().obtenerPosX();
    float y2 =  selector.ramal_slc.obtenerNodo2().obtenerPosY();
    float[] punto = Calculadora_geo.puntoPerpendicular(motor.rt_x, motor.rt_y, x1, y1, x2, y2);
    motor.mostrarLinea(motor.rt_x, motor.rt_y, punto[0], punto[1]);
  }
  
  //----------------------------|Mostrar Vista Previa|----------------------------\\
  public void mostrarVistaPrevia (float ratonX, float ratonY, Circuito circuito) {
    motor.actualizarRaton(ratonX, ratonY);
    selector.detectarSeleccion(motor.rt_x, motor.rt_y, this.rad, circuito);
    
    if (creador.obtenerModo().equals("Cables")) {    //Vista previa del creador de Cables
      println(motor.rt_x + " " + this.ult_x);
      
      if (cont % 2 == 1) {
        //Centrar Selección sobre el nodo
        Nodo nodo = selector.seleccionarNodo(this.ult_x, this.ult_y, this.rad, circuito);
        if (nodo != null)
          registrarClick(nodo.obtenerPosX(), nodo.obtenerPosY());

        motor.mostrarLinea(motor.rt_x, motor.rt_y, this.ult_x, this.ult_y);
      }
      
      return;
    }
    
    //Vista previa del creador de Componentes
    if (!creador.obtenerModo().equals("Resistor") && !creador.obtenerModo().equals("Fuente")) 
      return;
    
      //Si no hay ramal seleccionado
      if (selector.ramal_slc == null) {
        this.comp_temp.mostrarSueltoBloq(motor.rt_x, motor.rt_y, motor);
        return;
      }
        
      int pos = Math.round(selector.ramal_slc.calcularPosComponente(motor.rt_x, motor.rt_y));
      
      if (creador.validarColocacionComponente (motor.rt_x, motor.rt_y, rad, selector, selector.ramal_slc)) {
        int[] x = new int[] {selector.ramal_slc.nodo1.obtenerPosX(), selector.ramal_slc.nodo2.obtenerPosX()};
        int[] y = new int[] {selector.ramal_slc.nodo1.obtenerPosY(), selector.ramal_slc.nodo2.obtenerPosY()};
        this.comp_temp.modificarPos(pos);
        this.comp_temp.mostrar(x, y, motor);
      }
  }
  
  //----------------------------|Mostrar Información del Ramal|----------------------------\\
  public void mostrarInfoRamal (float ratonX, float ratonY, Circuito circuito) {
    if (!creador.obtenerModo().equals("Ninguno"))
      return;
    
    motor.actualizarRaton(ratonX, ratonY);
    selector.detectarSeleccion(motor.rt_x, motor.rt_y, this.rad, circuito);
    
    if (selector.ramal_slc == null) 
      return;
      
    if (selector.comp_slc != null)
      return;
      
    String[] info = selector.ramal_slc.obtenerInfo();
    String texto = "\nResistencia: " + info[1] + "\nCorriente: " + info[2] + "\nVoltaje: " + info[3] + "\nPotencia: " + info[4] + "\nFEM: " + info[5] + "\nPotencia (FEM): " + info[6];
    
    rect (ratonX, ratonY, 250, 250);
    fill(0);
    textAlign(CENTER);
    textSize(30);
    text(info[0], ratonX, ratonY, 250, 200);
    textAlign(0);
    textSize(20);
    text(texto, ratonX + 40, ratonY + 10, 210, 300);
    fill(255);
    println(texto);
  }
  
  //----------------------------|Mostrar Nombre de Cada Nodo|----------------------------\\
  public void mostrarNombreNodos (Circuito circuito) {
    circuito.mostrarNombreNodos(motor);
  }
  
  //---------------------------------------------------------------------------\\
  //                         |Actividad según Eventos|                         \\
  //---------------------------------------------------------------------------\\  
  
  //----------------------------|Armar Circuito|----------------------------\\
  public void armarCircuito (float ratonX, float ratonY, Circuito circuito) {
    presionar(ratonX, ratonY);
    creador.accionar(motor.rt_x, motor.rt_y, this.rad, circuito, this.selector);
  }
  
  //----------------------------|Presionar Interfaz|----------------------------\\
  private void presionar (float ratonX, float ratonY) {
    motor.actualizarRaton(ratonX, ratonY);
    registrarClick(motor.rt_x, motor.rt_y);
    
    if (creador.obtenerModo().equals("Cables"))
      this.cont += 1;
  }
  
  //----------------------------|Registrar Click|----------------------------\\
  private void registrarClick (float ratonX, float ratonY) {
    this.ult_x = ratonX;
    this.ult_y = ratonY;
  }
  
  //----------------------------|Cambiar Orientación|----------------------------\\
  public void cambiarOrientacion () {
    if (creador.obtenerModo().equals("Fuente")) {
      creador.cambiarOrientacion();
      this.comp_temp = new Fuente (1, 1, creador.obtenerOrientacion());
    }
  }
  
  //----------------------------|Seleccionar Modo|----------------------------\\
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
