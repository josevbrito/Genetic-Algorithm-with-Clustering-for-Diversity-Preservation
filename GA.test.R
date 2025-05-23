source('GA.R')
source('init.population.R')
source('crossover.R')
source('mutation.R')
source('selection.R')
source('Benchmarks.R')


set.seed(123)
it <- 1000
pop.size <- 50
#lb <- rep(-5.12,dim)
#ub <- rep(5.12,dim)
funcs <- c(Rosenbrock,Griewank,Ackley,Schwefel, Alpine)
bounds <- matrix(rep(NA,2*length(funcs)), nrow = 2)
res <- matrix(rep(NA,3*length(funcs)),nrow = 3)
bounds[1,] <- c(-5,-600,-32,-500,0)
bounds[2,] <- c(10,600,32,500,10)
dim <- 10
execs <- 30

result <-  vector("list",execs)
best <- rep(NA,execs)
#j = 1

cat("Running...\n")
#for(f in func){
for(f in 1:length(funcs)){
   lb <- rep(bounds[1,f],dim)
   ub <- rep(bounds[2,f],dim)
   #cat("f = ", f, "\n")
   for(i in 1:execs){
      #cat("exec = ",i,"\n")
      #cat("Func = ", f, "\n")
      result[[i]] <- GA(funcs[[f]], lb, ub, pop.size = pop.size, dimension = dim, max.it = it, pc = 0.6, pm = 0.01, sel = 1, elitism = TRUE)
      best[i] <- min(result[[i]]$fit) 
   }
   res[1,f] <- min(best)
   res[2,f] <- mean(best)
   res[3,f] <- sd(best)
   #j = j + 1
}
View(res)

