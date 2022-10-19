/*
|====================================================================|
*                      |Resolvedor de Circuitos|     
*                          (Clase estática)
* Descripción:                                                        
*   Clase utilizada para 
|====================================================================|
*/

public static class Resolvedor_circuitos {
  
  public static ArrayList<Circuito> obtenerMallas () {
    return null;
  }
  
  public static Circuito dijkstra (Circuito circuito, Nodo raiz) {
    //Circuito malla = new Circuito ();
    
    PriorityQueue<Nodo> cola = new PriorityQueue<Nodo>();
    
    ArrayList<Nodo> nodos = circuito.obtenerNodos();
    float[] distancia = new float [nodos.size()];
    Nodo[] previo = new Nodo [nodos.size()];
    
    ArrayList<Nodo> visitados = nodos;
    ArrayList<Nodo> no_visitados = new ArrayList<Nodo>();  
    
    for (int i = 0; i < nodos.size(); i++) {      
      if (nodos.get(i) == raiz) {
        cola.add(nodos.get(i));
        distancia[i] = 0;
        continue;
      }
        
      distancia[i] = 100;
      previo[i] = null;
      cola.add(nodos.get(i));
    }
    
    
    //Mientras no se vacíe la cola
    while (cola.size() > 0) {
      Nodo nodo = cola.remove();
      ArrayList<Nodo> vecinos = nodo.obtenerVecinos();
      
      for (Nodo n : vecinos) {
        if (visitados.contains(n))    //Si el nodo ya fue visitado
          continue;
          
        float temp = distancia[nodos.indexOf(n)] + 1;
        
        if (temp < distancia[nodos.indexOf(n)]) {
        }
      }
    }
    
    
    
    
    return null;
  }
  
  //-------------------------|Generar Matriz de Ecuaciones|-------------------------\\
  public static float[][] generarMatrizMalla (ArrayList<Circuito> mallas) {
    float[][] ecuaciones = new float[mallas.size()][];
    
    for (int i = 0; i < mallas.size(); i++)    //Generar la ecuación de cada malla
      ecuaciones[i] = generarEcuacionMalla(mallas, i);
      
    return ecuaciones;
  }
  
  //-------------------------|Generar Ecuación de Malla|-------------------------\\
  public static float[]generarEcuacionMalla (ArrayList<Circuito> mallas, int pos) {
    float[] ecuacion = new float[mallas.size() + 1];
    
    ArrayList<Ramal> ramales = mallas.get(pos).obtenerRamales();
    
    for (Ramal ramal : ramales) {
      //Agregar Componentes del Ramal a la Ecuación
      ecuacion[pos] = ecuacion[pos] + ramal.obtenerResistencia();
      ecuacion[mallas.size()] = ecuacion[mallas.size()] + ramal.obtenerFEM();
      
      for (int i = 0; i < mallas.size(); i++) {    //Verificar si el ramal hace parte de otra malla
         if (mallas.get(i) == mallas.get(pos))    //No realizar operación en el mismo circuito
           continue;
           
         if (ramalEnCircuito(mallas.get(i), ramal))  //Si lo es, incluirlo en la ecuación
           ecuacion[i] = ecuacion[i] - ramal.obtenerResistencia();
      }
    }
    
    return ecuacion;
  }
  
  //-------------------------|Verificar si un Componente está en el Circuito|-------------------------\\
  public static boolean componenteEnCircuito (Circuito circuito, Componente componente) {
    ArrayList<Ramal> ramales = circuito.obtenerRamales();
    
    for (Ramal ramal : ramales) {      //Verificar Cada Ramal del Circuito
      ArrayList<Componente> componentes = ramal.obtenerComponentes();
      
      if (componentes.contains(componente))  //Verificar los componentes de cada ramal
        return true;
    }
      
    return false;
  }
  
  //-------------------------|Verificar si un Ramal está en el Circuito|-------------------------\\
  public static boolean ramalEnCircuito (Circuito circuito, Ramal ramal) {
    return circuito.obtenerRamales().contains(ramal);
  }
}
