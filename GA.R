GA <- function(func, lb, ub, pop.size = 10, dimension = 10, max.it = 100, pc= 0.6, pm = 0.005, sel, t.size = 4, elitism = TRUE){
  tmp.pop <- matrix(rep(NA,pop.size*dimension), nrow = pop.size)
  init <- init.population(func,lb,ub,pop.size,dimension)
  pop <- init$pop
  fitness <- init$fit
  #print("Running...")
  for(it in 1:max.it){
    #print(i)
    tmp.pop <- selection(pop,pop.size,dimension,fitness,sel,t.size)
    #tmp.pop <- simple.crossover(lb, ub, pop.size, dimension, tmp.pop,pc)
    #tmp.pop <- arith.crossover(lb, ub, pop.size, dimension, tmp.pop,pc)
    #tmp.pop <- n.arith.crossover(lb, ub, pop.size, dimension, tmp.pop,pc,max.it,i)
    tmp.pop <- linear.crossover(lb, ub, pop.size, dimension, tmp.pop,pc,func)
    tmp.pop <- uniform.mutation(func,lb,ub,tmp.pop,pop.size,dimension,pm)
    #tmp.pop <- n.uniform.mutation(func,lb,ub,tmp.pop,pop.size,dimension,pm,max.it,it)
    tmp.fitness <- tmp.pop$fit
    tmp.pop <- tmp.pop$pop
    if (elitism == TRUE){
      best.tmp <- min(tmp.fitness)
      best.old <- min(fitness)
      if (best.old < best.tmp){
        idx <- which.min(fitness)
        idx.worst <- which.max(tmp.fitness)
        tmp.pop[idx.worst,] <- pop[idx,]
        tmp.fitness[idx.worst] <- fitness[idx]
      }
    } 
    fitness <- tmp.fitness
    pop <- tmp.pop
  }
  return(list(pop = pop, fit = fitness))
}