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
  
  public static float[] obtenerCorrientes (ArrayList<Circuito> mallas) {
      double[][] matriz = generarMatrizMalla(mallas);
      double[][] coeficientes = new double[mallas.size()][mallas.size()];
      
      for (int i = 0; i < matriz.length - 1; i++)
        coeficientes[i] = matriz[i];
      
      double[] valores = matriz[matriz.length - 1];
        
      double[] res = resolverSistema(coeficientes, valores);
      float[] corrientes = new float[res.length];
        
      for(int i = 0; i < res.length; i++) {
        corrientes[i] = (float)res[i];
        System.out.print(res[i]+" ");
      }
      
      return corrientes;
  }
  
  public static double[] resolverSistema(double[][] matrix, double[] coef) {
    try {
      RealMatrix coefficients = new Array2DRowRealMatrix(matrix ,false);
      DecompositionSolver solver = new LUDecomposition(coefficients).getSolver();
      RealVector constants = new ArrayRealVector(coef, false);
      RealVector solution = solver.solve(constants);  
      return solution.toArray();
    } catch (SingularMatrixException e) {
      return new double[0];
    }
  }
  
  //-------------------------|Generar Matriz de Ecuaciones|-------------------------\\
  public static double[][] generarMatrizMalla (ArrayList<Circuito> mallas) {
    double[][] ecuaciones = new double[mallas.size() + 1][];
    ecuaciones[mallas.size()] = new double [mallas.size()];
    
    for (int i = 0; i < mallas.size(); i++) {   //Generar la ecuación de cada malla
      double[] ecua = generarEcuacionMalla(mallas, i);
      double[] ecua_cor = new double [ecua.length - 1];
      
      for (int j = 0; j < ecua.length - 1; j++) {
        ecua_cor[j] = ecua[j];
      }
      
      ecuaciones[i] = ecua_cor;    //Guardar coeficientes
      ecuaciones[mallas.size()][i] = ecua[ecua.length - 1];  //Guardar valores - última fila
    }
      
    return ecuaciones;
  }
  
  //-------------------------|Generar Ecuación de Malla|-------------------------\\
  public static double[]generarEcuacionMalla (ArrayList<Circuito> mallas, int pos) {
    double[] ecuacion = new double [mallas.size() + 1];
    
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
