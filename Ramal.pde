/*
|====================================================================|
*                              |Ramal|         
* Descripción:                                                        
*   Clase utilizada para 
|====================================================================|
*/

public class Ramal {
  private Nodo nodo1, nodo2;
  private ArrayList<Componente> componentes;
  private float longitud;
  private int corriente;
  private int voltaje;
  private int potencia;
  
  public Ramal (Nodo nodo1, Nodo nodo2) {
    //Ingresar Nodos extremos
    this.nodo1 = nodo1;
    this.nodo2 = nodo2;
    
    calcularLongitud();
    
    //Conectar Nodos mediante Ramal
    this.nodo1.agregarRamal (this);
    this.nodo2.agregarRamal (this);
    
    this.componentes = new ArrayList<Componente>();
  }
  
  //-------------------------|Modificar Posiciones|-------------------------\\
  public Nodo siguienteNodo (Nodo nodo) {
    if (nodo == nodo1)
      return nodo2;
      
    if (nodo == nodo2)
      return nodo1;
      
    return null;
  }
  
  //-------------------------|Calcular Longitud del Ramal|-------------------------\\
  private void calcularLongitud () {
    int x1 = this.nodo1.obtenerPosX();
    int y1 = this.nodo1.obtenerPosY();
    int x2 = this.nodo2.obtenerPosX();
    int y2 = this.nodo2.obtenerPosY();
    this.longitud = Calculadora_geo.calcularDistancia (x1, y1, x2, y2);
    println(this.longitud);
  }
  
  //-------------------------|Agregar Componentes|-------------------------\\
  public void agregarComponente (Componente componente) {
    this.componentes.add(componente);
  }
  
  //-------------------------|Mostrar Componentes|-------------------------\\
  public void mostrar (Motor_grafico motor) {
    motor.mostrarLinea(nodo1.obtenerPosX(), nodo1.obtenerPosY(), nodo2.obtenerPosX(), nodo2.obtenerPosY());
    
    for (int i = 0; i < this.componentes.size(); i++) {
      int[] x = new int[] {this.nodo1.obtenerPosX(), this.nodo2.obtenerPosX()};
      int[] y = new int[] {this.nodo1.obtenerPosY(), this.nodo2.obtenerPosY()};
      this.componentes.get(i).mostrar(x, y, motor);
    }
  }
  
  public void mostrarAreaSeleccion (int rad, Motor_grafico motor) {
    int x1 = nodo1.obtenerPosX();
    int y1 = nodo1.obtenerPosY();
    int x2 = nodo2.obtenerPosX();
    int y2 = nodo2.obtenerPosY();
  
    int[][] area_cuadrada = Calculadora_geo.calcularAreaCuadrada(x1, y1, x2, y2, rad);
    
    interfaz.motor.mostrarLinea(area_cuadrada[0][0], area_cuadrada[1][0], area_cuadrada[0][1], area_cuadrada[1][1]);
    interfaz.motor.mostrarLinea(area_cuadrada[0][1], area_cuadrada[1][1], area_cuadrada[0][2], area_cuadrada[1][2]);
    interfaz.motor.mostrarLinea(area_cuadrada[0][2], area_cuadrada[1][2], area_cuadrada[0][3], area_cuadrada[1][3]);
    interfaz.motor.mostrarLinea(area_cuadrada[0][3], area_cuadrada[1][3], area_cuadrada[0][0], area_cuadrada[1][0]);
  }
  
  
  public ArrayList<Componente> obtenerComponentes () {
    return this.componentes;
  }
  
  //-------------------------|Obtener Nodo 1|-------------------------\\
  public Nodo obtenerNodo1 () {
    return this.nodo1;
  }
  
  //-------------------------|Obtener Nodo 2|-------------------------\\
  public Nodo obtenerNodo2 () {
    return this.nodo2;
  }
  
  //-------------------------|Obtener Nombre|-------------------------\\
  public String obtenerNombre () {
    return this.nodo1.obtenerNombre() + this.nodo2.obtenerNombre();
  }
}
