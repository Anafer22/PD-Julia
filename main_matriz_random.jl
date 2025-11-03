# Añade los directorios 'src' y 'data' al 'LOAD_PATH' de Julia, esto permite que Julia encuentre nuestros módulos
push!(LOAD_PATH, "./src/")
push!(LOAD_PATH, "./data/")

# Importar modulos necesarios
using cod_fuente_random  
using tsp_matriz_random  
using Printf               
using Random              

#Función Principal (main)
function main_tsp_random()
    println("Iniciando TSP-RANDOM")
    # Cargar Datos
    println("Cargando matriz")

# Parámetros del experimento, las ciudades se pueden mover hasta un maximo de 22.
    N_CIUDADES = 20

# Tu defines la semilla, Usar la misma semilla (22) garantiza que la matriz "aleatoria" que de genere 
# sea siempre la misma, haciendo el experimento reproducible.
    SEMILLA = 22

# Planta la semilla (22) en el generador de números aleatorios. A partir de esta línea,
# cualquier llamada a rand() seguirá una secuencia predecible y fija.
    Random.seed!(SEMILLA)

    println("Generando matriz de $N_CIUDADES ciudades y (Semilla: $SEMILLA)")
# Llamamos a la función de 'tsp_matriz_random' para generar la matriz de distancias
    distancia_matriz = tsp_matriz_random.tsp_matrix(SEMILLA, n_ciudades=N_CIUDADES)
    println("Matriz generada")
    tiempo_inicio = time()

# Ejecutar el algoritmo TSP con PD 
    (costo_total, ruta_optima) = cod_fuente_random.tsp_mat_random(distancia_matriz)
    tiempo_final = time()
    tiempo_transcurrido = tiempo_final - tiempo_inicio

    println("\n Resultados:")
    println("Semilla aleatoria fija: $SEMILLA")
    println("Costo total calculado: ", costo_total)
    
"""Formatear la ruta para que sea facil de leer, ya que mapea la lista para cada elemento c y lo convierte en un
string y devuelve C1 -> C5 -> ... -> C1"""
    ruta_texto = join(map(c -> "C$c", ruta_optima), " -> ")
    println("Representación de la ruta:")
    println("$ruta_texto")
    
    ruta_sin_final = ruta_optima[1:end-1]
    es_valida = length(unique(ruta_sin_final)) == N_CIUDADES
    println("Ruta válida: ", es_valida ? "Sí" : "No")

# Imprime el tiempo en la CONSOLA
    @printf "Tiempo de ejecución: %.6f segundos.\n" tiempo_transcurrido

# Guardar Resultados en results
    resultados = "results/tsp_random_20C_results.txt"
    mkpath("results")
    println("\nGuardando resultados en: $resultados")

    try
        open(resultados, "w") do f
            write(f, "Resultados de TSP-RANDOM con programación dinámica\n")
            write(f, "\n")
            write(f, "Ciudades: $N_CIUDADES\n")
            write(f, "Semilla aleatoria fija: $SEMILLA\n\n")
            write(f, "Métricas:\n")
            write(f, "Costo total óptimo: $costo_total\n")
# Imprime el tiempo en el ARCHIVO
            @printf f "Tiempo de ejecución: %.6f segundos\n\n" tiempo_transcurrido
            write(f, "Criterios de verificación:\n")
            write(f, "Ruta válida sin repeticiones: $es_valida\n")
            write(f, "Reproducibilidad: Semilla '$SEMILLA' fija\n\n")
            write(f, "Ruta óptima:\n")
            write(f, "$ruta_texto\n")
        end
    catch e
        println("ERROR: No se pudo guardar el archivo de resultados.")
        println(e)
    end
    
end

main_tsp_random()