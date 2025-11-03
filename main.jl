# Añade los directorios 'src' y 'data' al 'LOAD_PATH' de Julia, esto permite que Julia encuentre nuestros módulos
push!(LOAD_PATH, "./src/")
push!(LOAD_PATH, "./data/")

# Importar modulos necesarios
using cod_fuente  # Nuestro algoritmo
using tsp_matrices_10  # Nuestros datos
using Printf     # modulo que imprime el texto con formato

#Función Principal (main)
function main()
    println("Iniciando TSP-10")

    # Cargar Datos
    println("Cargando matriz")

# Llama a la funcion tsp10_matrix del modulo tsp_matrices_10 y la guarda en matriz_de_10
    matriz_de_10 = tsp_matrices_10.tsp10_matrix() 
# Obtiene el tamaño de la primera dimensión (las filas) de la matriz.
    n_ciudades = size(matriz_de_10, 1)
    println("Datos cargados de las: $n_ciudades ciudades")
    println("Ejecutando el algoritmo de Programación dinamica")
    
# Medir el tiempo de ejecución
    inicio = time()
"""Llama a la funcion tsp_mat_diez del modulo cod_fuente, y le pasa la matriz_de_10, el algoritmo se ejecuta
#y devuelve una tupla"""
    (costo_total, ruta_optima) = cod_fuente.tsp_mat_diez(matriz_de_10)
    fin = time()
# Calcula la diferencia para saber cuántos segundos tardó el algoritmo.
    tiempo_transcurrido = fin - inicio

    println("\n Resultados obtenidos")
    println("Costo total calculado: ", costo_total)
    
"""Formatear la ruta para que sea facil de leer, ya que mapea la lista para cada elemento c y lo convierte en un
string y devuelve C1 -> C5 -> ... -> C1"""
    ruta_texto = join(map(c -> "C$c", ruta_optima), " -> ")
    println("Representación de la ruta:")
# Imprime la ruta formateada que acabamos de crear
    println("$ruta_texto")
    
# Crea una copia de la ruta pero sin el último elemento. 
    ruta_sin_final = ruta_optima[1:end-1] 
""" unique() elimina cualquier ciudad repetida de la ruta_sin_final, length() cuenta cuántas ciudades únicas 
quedaron, y == n_ciudades comprueba si ese conteo es igual al número total de ciudades (10). Si son iguales, 
es_valida se guarda como true."""
    es_valida = length(unique(ruta_sin_final)) == n_ciudades
    println("Ruta válida: ", es_valida ? "Sí" : "No")
    @printf "   Tiempo de ejecución: %.6f segundos.\n" tiempo_transcurrido

# Guardar resultados en la carpeta results
    resultados = "results/tsp10_results.txt"
    mkpath("results") # Asegura que el directorio exista
    println("\nGuardando resultados en: $resultados")
    try
        open(resultados, "w") do f
            write(f, "Resultados de (TSP-10) con programación dinámica\n")
            write(f, "\n")
            write(f, "Métricas:\n")
            write(f, "Costo total óptimo: $costo_total\n")
            write(f, "Ruta óptima: $ruta_texto\n")
            write(f, "Tiempo de ejecución: $tiempo_transcurrido en segundos\n\n")
            write(f, "Criterios de verificación:\n")
            write(f, "Ruta válida sin repeticiones: $es_valida\n")
            write(f, "Cálculo correcto del costo: $costo_total\n")
        end
        println("Resultados guardados exitosamente.")
    catch e
        println("ERROR: No se pudo guardar el archivo de resultados.")
        println(e)
    end
end
main()