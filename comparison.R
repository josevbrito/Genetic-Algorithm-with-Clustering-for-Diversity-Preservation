
run_comparison_experiment <- function() {
  set.seed(123)
  
  # Parâmetros experimentais
  execs <- 30
  pop.size <- 50
  max.it <- 500
  dimension <- 10
  
  # Funções de teste
  functions <- list(
    Sphere = list(func = Sphere, lb = -5.12, ub = 5.12, name = "Esfera (Monomodal)"),
    Schwefel = list(func = Schwefel, lb = -500, ub = 500, name = "Schwefel (Multimodal)")
  )
  
  # Variantes do algoritmo
  algorithms <- c("GA_Padrão", "GA_KMeans", "GA_Hierárquico", "GA_DBSCAN")
  
  # Armazenamento de resultados
  results <- array(NA, dim = c(length(functions), length(algorithms), execs))
  convergence_data <- list()
  
  cat("Iniciando experimento de comparação...\n")
  
  for(f_idx in 1:length(functions)) {
    func_info <- functions[[f_idx]]
    func <- func_info$func
    lb <- rep(func_info$lb, dimension)
    ub <- rep(func_info$ub, dimension)
    
    cat("Testando função:", func_info$name, "\n")
    
    for(alg_idx in 1:length(algorithms)) {
      algorithm <- algorithms[alg_idx]
      cat("  Algoritmo:", algorithm, "\n")
      
      for(exec in 1:execs) {
        if(exec %% 10 == 0) cat("    Execução:", exec, "\n")
        
        if(algorithm == "GA_Padrão") {
          result <- GA_standard(func, lb, ub, pop.size, dimension, max.it)
        } else if(algorithm == "GA_KMeans") {
          result <- GA_kmeans(func, lb, ub, pop.size, dimension, max.it)
        } else if(algorithm == "GA_Hierárquico") {
          result <- GA_hierarchical(func, lb, ub, pop.size, dimension, max.it)
        } else if(algorithm == "GA_DBSCAN") {
          result <- GA_dbscan(func, lb, ub, pop.size, dimension, max.it)
        }
        
        results[f_idx, alg_idx, exec] <- min(result$fit)
        
        # Armazena os dados de convergência para a primeira execução
        if(exec == 1) {
          convergence_key <- paste(func_info$name, algorithm, sep = "_")
          convergence_data[[convergence_key]] <- result$best_history
        }
      }
    }
  }
  
  return(list(results = results, convergence_data = convergence_data, 
              functions = functions, algorithms = algorithms))
}

# Função de análise estatística
perform_statistical_analysis <- function(experiment_results) {
  results <- experiment_results$results
  functions <- experiment_results$functions
  algorithms <- experiment_results$algorithms
  
  cat("\n============================================================================\n")
  cat("RESULTADOS DA ANÁLISE ESTATÍSTICA\n")
  cat("============================================================================\n")
  
  for(f_idx in 1:length(functions)) {
    func_name <- names(functions)[f_idx]
    cat("\nFunção:", functions[[f_idx]]$name, "\n")
    cat(paste(rep("=", 50), collapse = ""), "\n")
    
    # Extração dos resultados para essa função
    func_results <- results[f_idx, , ]
    
    # Estatísticas de resumo
    cat("\nEstatísticas de Resumo:\n")
    cat(sprintf("%-15s %12s %12s %12s %12s\n", "Algoritmo", "Média", "Desvio Padrão", "Mínimo", "Máximo"))
    cat(paste(rep("-", 70), collapse = ""), "\n")
    
    for(alg_idx in 1:length(algorithms)) {
      alg_results <- func_results[alg_idx, ]
      cat(sprintf("%-15s %12.6f %12.6f %12.6f %12.6f\n", 
                  algorithms[alg_idx], mean(alg_results), sd(alg_results), 
                  min(alg_results), max(alg_results)))
    }
    
    # Teste ANOVA
    cat("\nTeste ANOVA:\n")
    data_for_anova <- data.frame(
      value = as.vector(func_results),
      algorithm = rep(algorithms, each = ncol(func_results))
    )
    
    anova_result <- aov(value ~ algorithm, data = data_for_anova)
    anova_summary <- summary(anova_result)
    print(anova_summary)
    
    # Teste HSD de Tukey se ANOVA for significativo
    p_value <- anova_summary[[1]][["Pr(>F)"]][1]
    if(!is.na(p_value) && p_value < 0.05) {
      cat("\nTeste HSD de Tukey (comparações pareadas):\n")
      tukey_result <- TukeyHSD(anova_result)
      print(tukey_result)
    } else {
      cat("\nANOVA não significativa (p >= 0.05), ignorando o teste de Tukey.\n")
    }
  }
}

# Função de visualização
create_convergence_plots <- function(experiment_results) {
  convergence_data <- experiment_results$convergence_data
  functions <- experiment_results$functions
  algorithms <- experiment_results$algorithms
  
  # Criação dos gráficos para cada função
  for(func_name in names(functions)) {
    # Extração dos dados de convergência para esta função
    func_convergence <- list()
    for(alg in algorithms) {
      key <- paste(functions[[func_name]]$name, alg, sep = "_")
      if(key %in% names(convergence_data)) {
        func_convergence[[alg]] <- convergence_data[[key]]
      }
    }
    
    if(length(func_convergence) > 0) {
      # Plotando as curvas de convergência
      max_length <- max(sapply(func_convergence, length))
      
      plot(1:max_length, func_convergence[[1]], type = "l", col = 1, 
           xlab = "Geração", ylab = "Melhor Fitness", 
           main = paste("Comparação de Convergência -", functions[[func_name]]$name),
           ylim = range(unlist(func_convergence), na.rm = TRUE))
      
      colors <- c("black", "red", "blue", "green")
      for(i in 1:length(func_convergence)) {
        lines(1:length(func_convergence[[i]]), func_convergence[[i]], 
              col = colors[i], lwd = 2)
      }
      
      legend("topright", legend = names(func_convergence), 
             col = colors[1:length(func_convergence)], lwd = 2)
    }
  }
}