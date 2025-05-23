uniform.mutation <- function(func,lb,ub,pop,pop.size,dimension,pm){
  r <- matrix(runif(pop.size*dimension),nrow=pop.size)
  fitness <- rep(NA,pop.size)
  #it gets the index of genes being mutated 
  idx <- which(r < pm,arr.ind=TRUE)
  #idx <- r < pm
  pop[idx] <- lb[idx[,2]] + runif(nrow(idx)) * (ub[idx[,2]] - lb[idx[,2]])
  fitness <- apply(pop,1,func)
  return(list(pop = pop, fit = fitness))
}

n.uniform.mutation <- function(func,lb,ub,pop,pop.size,dimension,pm,max.it,it){
  r <- matrix(runif(pop.size*dimension),nrow=pop.size)
  fitness <- rep(NA,pop.size)
  idx <- which(r < pm,arr.ind=TRUE)
  values <- pop[idx]
  r <- sample(c(0,1), nrow(idx), replace = TRUE)
  tmp.idx <- r == 0
  #because length(lb and ub) is equal dimension we have to redimensionate them accordingly
  #the same column can be selected more than once
  tmp.lb <- lb[idx[,2]]
  tmp.ub <- ub[idx[,2]]
  values[tmp.idx] <-   values[tmp.idx] + delta(it,max.it,tmp.ub[tmp.idx]-values[tmp.idx])
  values[!tmp.idx] <- values[!tmp.idx] - delta(it,max.it,values[!tmp.idx]-tmp.lb[!tmp.idx])
  #if(values < lb || values > ub) print("Out of limits..." )
  pop[idx] <- values
  fitness <- apply(pop,1,func)
  return(list(pop = pop, fit = fitness))
}

delta <- function(it, max.it,y, b=5){
  r <- runif(length(y))
  y <- y * (1 - r^((1-it/max.it)^b))
  return(y)
} 