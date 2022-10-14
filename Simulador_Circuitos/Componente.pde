/*
|====================================================================|
*                           |Componente|         
* Descripción:                                                        
*   Clase utilizada para 
|====================================================================|
*/

public class Componente {
  protected float pos, largo;
  protected String nombre;
  
  public Componente (float pos, float largo, String nombre) {
    this.pos = pos;
    this.largo = largo;
    this.nombre = nombre;
  }
    
  public float obtenerPos () {
    return this.pos;
  }
  
  public float obtenerLargo () {
    return this.largo;
  }
  
  public void modificarPos (float pos) {
    this.pos = pos;
  }
  
  public float[][] obtenerPuntos (int[] x, int[] y) {
    float[] p1 = Calculadora_geo.calcularPuntoRecta (x[0], y[0], x[1], y[1], this.pos);
    float[] p2 = Calculadora_geo.calcularPuntoRecta (x[0], y[0], x[1], y[1], this.pos + this.largo);
    return new float[][] {{p1[0], p2[0]}, {p1[1], p2[1]}}; 
  }
  
  public void mostrarAreaSeleccion (int[] x, int[] y, int rad, Motor_grafico motor) {
    int[][] linea = Calculadora_geo.aproxMatriz(obtenerPuntos(x, y));
    int[][] area_cuadrada = Calculadora_geo.calcularAreaCuadrada(linea[0][0], linea[1][0], linea[0][1], linea[1][1], rad);
    
    interfaz.motor.mostrarLinea(area_cuadrada[0][0], area_cuadrada[1][0], area_cuadrada[0][1], area_cuadrada[1][1]);
    interfaz.motor.mostrarLinea(area_cuadrada[0][1], area_cuadrada[1][1], area_cuadrada[0][2], area_cuadrada[1][2]);
    interfaz.motor.mostrarLinea(area_cuadrada[0][2], area_cuadrada[1][2], area_cuadrada[0][3], area_cuadrada[1][3]);
    interfaz.motor.mostrarLinea(area_cuadrada[0][3], area_cuadrada[1][3], area_cuadrada[0][0], area_cuadrada[1][0]);
  }
  
  public void mostrar (int[] x, int[] y, Motor_grafico motor) {   
    int[][] linea = Calculadora_geo.aproxMatriz(obtenerPuntos(x, y));
    int[][] area_cuadrada = Calculadora_geo.calcularAreaCuadrada(linea[0][0], linea[1][0], linea[0][1], linea[1][1], 100);    
    float m = Calculadora_geo.calcularPendiente(linea[0][0], linea[1][0], linea[0][1], linea[1][1]);
    float angulo = atan(m);
    
    //Si la Recta es paralela al eje X y orientación negativa
    if (m == 0 && x[0] > x[1]) {
      motor.mostrar(this.nombre, area_cuadrada[0][3], area_cuadrada[1][3], this.largo, 200);
      return;
    }
    
    //Si la Recta es paralela al eje X y orientación positiva
    if (m == 0) {
      motor.mostrar(this.nombre, area_cuadrada[0][0], area_cuadrada[1][0], this.largo, 200);
      return;
    }
    
    if (m > 0)  //Si la pendiente es positiva : ajustar ángulo
      angulo = PI+angulo;
      
    //Si la Recta es de orientación positiva en el eje Y (nodo1 > nodo2)
    if (y[0] > y[1]) {
      angulo = PI+angulo;
      motor.mostrar_inc(this.nombre, area_cuadrada[0][0], area_cuadrada[1][0], this.largo, 200, -angulo);
      return;
    }
    
    //Si la Recta es de orientación negativa en el eje Y (nodo1 < nodo2)
    motor.mostrar_inc(this.nombre, area_cuadrada[0][1], area_cuadrada[1][1], this.largo, 200, -angulo);
  }
  
  public void mostrarBloq (int[] x, int[] y, Motor_grafico motor) {
    String temp = this.nombre;
    this.nombre = this.nombre + "-bloqueado";
    
    this.mostrar(x, y, motor);
    this.nombre = temp;
  }
  
  public void mostrarSuelto (float x, float y, Motor_grafico motor) {
    motor.mostrar(this.nombre, x, y, this.largo, 200);
  }
  
  public void mostrarSueltoBloq (float x, float y, Motor_grafico motor) {
    String temp = this.nombre;
    this.nombre = this.nombre + "-bloqueado";
    
    this.mostrarSuelto(x, y, motor);
    this.nombre = temp;
  }
}


public class Resistor extends Componente {
  private float resistencia;
  
  public Resistor (float pos, float resistencia) {
    super(pos, 300, "Resistor");
    this.resistencia = resistencia;  
  }
}


public class Fuente extends Componente {
  private float voltaje;
  private boolean orientacion;
  
  public Fuente (float pos, float voltaje, boolean orientacion) {
    super(pos, 300, "Fuente");
    this.voltaje = voltaje;
    this.orientacion = orientacion;
  }
}
