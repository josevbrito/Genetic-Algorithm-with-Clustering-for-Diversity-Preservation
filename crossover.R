#simple.crossover <- function(func,lb,ub,pop.size,dimension,pop,pc){
simple.crossover <- function(lb,ub,pop.size,dimension,pop,pc){
   new.pop <- matrix(rep(NA,pop.size*dimension), nrow = pop.size)
   r <- runif(pop.size)
   idx <- (r < pc)
   pop <- pop[idx,]
   tmp.pop.size <- nrow(pop)
   for(i in seq(1,pop.size, by = 2)){  
     indivs <- sample(1:tmp.pop.size,2,replace = FALSE)
     cross.point  <- sample(2:(dimension-1),1)
     offspring1   <- c(pop[indivs[1],1:cross.point],pop[indivs[2],(cross.point+1):dimension])
     offspring2   <- c(pop[indivs[2],1:cross.point],pop[indivs[1],(cross.point+1):dimension])
     new.pop[i,]   <- offspring1
     new.pop[i+1,] <- offspring2
   }
   return(pop = new.pop)
}

#Arithmetical
arith.crossover <- function(lb,ub,pop.size,dimension,pop,pc){
  new.pop <- matrix(rep(NA,pop.size*dimension), nrow = pop.size)
  r <- runif(pop.size)
  idx <- (r < pc)
  pop <- pop[idx,]
  tmp.pop.size <- nrow(pop)
  for(i in seq(1,pop.size, by = 2)){  
    l = runif(1)
    indivs <- sample(1:tmp.pop.size,2,replace = FALSE)
    new.pop[i,] <- l*pop[indivs[1],] + (1-l)*pop[indivs[2],]
    new.pop[i+1,] <- (l-1)*pop[indivs[1],] + l*pop[indivs[2],]
  }
  return(pop = new.pop)
    
}

#non-uniform Arithmetical
n.arith.crossover <- function(lb,ub,pop.size,dimension,pop,pc,max.it,t){
  new.pop <- matrix(rep(NA,pop.size*dimension), nrow = pop.size)
  r <- runif(pop.size)
  idx <- (r < pc)
  pop <- pop[idx,]
  tmp.pop.size <- nrow(pop)
  l = t/max.it
  for(i in seq(1,pop.size, by = 2)){  
    indivs <- sample(1:tmp.pop.size,2,replace = FALSE)
    new.pop[i,] <- l*pop[indivs[1],] + (1-l)*pop[indivs[2],]
    new.pop[i+1,] <- (l-1)*pop[indivs[1],] + l*pop[indivs[2],]
  }
  return(pop = new.pop)
}


#linear
linear.crossover <- function(lb,ub,pop.size,dimension,pop,pc,func){
  new.indiv <- matrix(rep(NA, 3*dimension), nrow = 3)
  new.fit <- rep(NA,3)
  new.pop <- matrix(rep(NA,pop.size*dimension), nrow = pop.size)
  r <- runif(pop.size)
  idx <- (r < pc)
  pop <- pop[idx,]
  tmp.pop.size <- nrow(pop)
  for(i in seq(1,pop.size, by = 2)){  
    indivs <- sample(1:tmp.pop.size,2,replace = FALSE)
    new.indiv[1,] <- 0.5*pop[indivs[1],] + 0.5*pop[indivs[2],]
    new.indiv[2,] <- 1.5*pop[indivs[1],] - 0.5*pop[indivs[2],]
    new.indiv[3,] <- -0.5*pop[indivs[1],] + 1.5*pop[indivs[2],]
    idx <- which(new.indiv < lb, arr.ind = TRUE)
    if (nrow(idx)>0) 
       new.indiv[idx] <- lb[idx[,2]] 
    idx <- which(new.indiv > ub, arr.ind = TRUE)
    if (nrow(idx)>0) 
      new.indiv[idx] <- ub[idx[,2]]
    new.fit <- apply(new.indiv,1,func)
    tmp <- cbind(new.fit,new.indiv)
    tmp <- tmp[order(tmp[,1]),]
    new.pop[i,] <- tmp[1,2:(dimension+1)]
    new.pop[i+1,] <- tmp[2,2:(dimension+1)]
  }
  return(pop = new.pop)
}

