Rosenbrock <- function(x){
  x1 <- x[1:length(x)-1]
  x2 <- x[2:length(x)]
  return(sum(100 * (x1 - x2^2)^2 + (x1-1)^2))
}

Griewank <- function(x){
  i <- sqrt(1:length(x))
  return(1/4000 * sum(x^2)-prod(cos(x)/i))
}

Ackley <- function(x){
  #wrong
  n <- length(x)
  return(-20 * exp(-0.2 * sqrt(sum(x^2/n))) - exp(1/n*sum(cos(2*pi*x))) + 20 +exp(1))
}

#Rastrigin <- function(x){
#  return(sum(x^2-10*cos(2*pi*x)+10))
#}

Schwefel <- function(x){
return(-sum(x*sin(sqrt(abs(x)))))  
}

Alpine <- function(x){
 return(sum(abs(x*sin(x)+0.1*x))) 
}



