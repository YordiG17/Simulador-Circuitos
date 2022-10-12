/*
|====================================================================|
*                           |Componente|         
* Descripción:                                                        
*   Clase utilizada para 
|====================================================================|
*/

public class Componente {
  protected float pos, largo;
  
  public Componente (float pos, float largo) {
    this.pos = pos;
    this.largo = largo;
  }
  
  public void mostrar (int[] x, int[] y, Motor_grafico motor) {
    System.out.println("Mostrando componente");
  }
  
  public float obtenerPos () {
    return this.pos;
  }
  
  public float obtenerLargo () {
    return this.largo;
  }
}


public class Resistor extends Componente {
  private float resistencia;
  
  public Resistor (float pos, float resistencia) {
    super(pos, 100);
    this.resistencia = resistencia;  
  }
  
  public void mostrar (int[] x, int[] y, Motor_grafico motor) {
    float[] p1 = Calculadora_geo.calcularPuntoRecta (x[0], y[0], x[1], y[1], this.pos);
    float[] p2 = Calculadora_geo.calcularPuntoRecta (x[0], y[0], x[1], y[1], this.pos + this.largo);
    motor.mostrar("Resistor", p1[0], p1[1], 100, 100);
  }
}


public class Fuente extends Componente {
  private float voltaje;
  private boolean orientacion;
  
  public Fuente (float pos, float voltaje, boolean orientacion) {
    super(pos, 100);
    this.voltaje = voltaje;
    this.orientacion = orientacion;
  }
  
  public void mostrar (int[] x, int[] y, Motor_grafico motor) {
    float[] p1 = Calculadora_geo.calcularPuntoRecta (x[0], y[0], x[1], y[1], this.pos);
    float[] p2 = Calculadora_geo.calcularPuntoRecta (x[0], y[0], x[1], y[1], this.pos + this.largo);
    motor.mostrar("Fuente", p1[0], p1[1], 100, 100);
  }
}
