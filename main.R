source('GA.R')
source('init.population.R')
source('crossover.R')
source('mutation.R')
source('selection.R')
source('Benchmarks.R')
source('clustering.R')
source('comparison.R')


# Run no experimento completo
cat("Iniciando o experimento abrangente de agrupamento GA...\n")
experiment_results <- run_comparison_experiment()

# Análise estatística
perform_statistical_analysis(experiment_results)

# Gráficos de Convergência
par(mfrow = c(1, 2))
create_convergence_plots(experiment_results)

cat("\n============================================================================\n")
cat("EXPERIMENTO CONCLUÍDO\n")
cat("============================================================================\n")
cat("Resumo dos Resultados:\n")
cat("- Testadas 2 funções de benchmark (Esfera - monomodal, Schwefel - multimodal)\n")
cat("- Comparadas 4 variantes de algoritmo:\n")
cat("  1. GA Padrão\n")
cat("  2. GA com agrupamento K-means\n")
cat("  3. GA com agrupamento Hierárquico\n") 
cat("  4. GA com agrupamento DBSCAN\n")
cat("- 30 execuções independentes por combinação algoritmo-função\n")
cat("- Significância estatística testada com ANOVA e Tukey HSD\n")
cat("- Gráficos de convergência gerados para comparação visual\n")
cat("============================================================================\n")

