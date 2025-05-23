selection <- function(pop,pop.size,dimension,fitness,sel,t.size){
   if (sel == 1)
      new.pop <- roulette.wheel(pop,fitness,pop.size,dimension)
   else
      new.pop <- tournament(pop,fitness,pop.size,dimension,t.size)
   return(new.pop)
}

roulette.wheel <- function(pop, fitness, pop.size, dimension){
  new.pop <- matrix(rep(NA, pop.size*dimension), nrow=pop.size)
  new.fit <- rep(NA,pop.size)
  F <- sum(fitness)
  p  <- -fitness/F
  q <- cumsum(p)
  r <- runif(pop.size)
  for (i in 1:pop.size){
    if (r[i] < q[1]){
      new.pop[i,] <- pop[1,]
    }
    else{
      idx <- which.min(q < r[i])
      new.pop[i,] <- pop[idx,]
    }
  }
  return(new.pop)
}

tournament <- function(pop,fitness,pop.size,dimension,t.size = 4){
  new.pop <- matrix(rep(NA,pop.size*dimension), nrow=pop.size)
  for(i in 1:pop.size){
    idx <- sample(1:pop.size, t.size) 
    pos <- which.min(fitness[idx])
    new.pop[i,] <- pop[idx[pos],]
  }
  return(new.pop)
}