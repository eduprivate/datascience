library(manipulate)
myHist <- function(mu){
  g <- ggplot(galton, aes(x = child))
  g <- g + geom_histogram(fill = "salmon",
                          binwidth=1, aes(y = ..density..), colour = "black")
  g <- g + geom_density(size = 2)
  g <- g + geom_vline(xintercept = mu, size = 2)
  mse <- round(mean((galton$child - mu)^2), 3)
  g <- g + labs(title = paste('mu = ', mu, ' MSE = ', mse))
  g
}
manipulate(myHist(mu), mu = slider(62, 74, step = 0.5))

#######################

nosim <- 1000
n <- 10
sd(apply(matrix(rnorm(nosim * n), nosim), 1, mean))

1 / sqrt(n)

#######################

nosim <- 1000
n <- 10
sd(apply(matrix(runif(nosim * n), nosim), 1, mean))

1 / sqrt(12 * n)

#######################

nosim <- 1000
n <- 10
sd(apply(matrix(rpois(nosim * n, 4), nosim), 1, mean))

######################

nosim <- 1000
n <- 10
sd(apply(matrix(sample(0 : 1, nosim * n, replace = TRUE),
                nosim), 1, mean))

######################

library(UsingR); data(father.son);
x <- father.son$sheight
n<-length(x)

round(c(var(x), var(x) / n, sd(x), sd(x) / sqrt(n)),2)

##############################

choose(8, 7) * 0.5^8 + choose(8, 8) * 0.5^8

pbinom(6, size = 8, prob = 0.5, lower.tail = FALSE)

pbinom(6, size = 8, prob = 0.5, lower.tail = FALSE)

qnorm(.95, mean = 1100, sd = 75)

pnorm(1160, mean = 1020, sd = 50, lower.tail = FALSE)
pnorm(70, mean = 80, sd = 10, lower.tail = FALSE)

qnorm(0.75, mean = 1020, sd = 50)

ppois(3, lambda = 2.5 * 4)

ppois(10, lambda = 5 * 3)

pbinom(2, size = 500, prob = 0.01)

ppois(2, lambda = 500 * 0.01)

#######################

n <- 10000
means <- cumsum(rnorm(n))/(1:n)
library(ggplot2)
g <- ggplot(data.frame(x = 1:n, y = means), aes(x = x, y = y))
g <- g + geom_hline(yintercept = 0) + geom_line(size = 2)
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g

#####################

means <- cumsum(sample(0:1, n, replace = TRUE))/(1:n)
g <- ggplot(data.frame(x = 1:n, y = means), aes(x = x, y = y))
g <- g + geom_hline(yintercept = 0.5) + geom_line(size = 2)
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g

####################

library(UsingR)
data(father.son)
x <- father.son$sheight
(mean(x) + c(-1, 1) * qnorm(0.975) * sd(x)/sqrt(length(x)))/12

#####################

round(1/sqrt(10^(1:6)), 3)

0.56 + c(-1, 1) * qnorm(0.975) * sqrt(0.56 * 0.44/100)

binom.test(56, 100)$conf.int

#####################

n <- 20
pvals <- seq(0.1, 0.9, by = 0.05)
nosim <- 1000
coverage <- sapply(pvals, function(p) {
  phats <- rbinom(nosim, prob = p, size = n)/n
  ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)
  ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)
  mean(ll < p & ul > p)
})

####################

n <- 100
pvals <- seq(0.1, 0.9, by = 0.05)
nosim <- 1000
coverage2 <- sapply(pvals, function(p) {
  phats <- rbinom(nosim, prob = p, size = n)/n
  ll <- phats - qnorm(0.975) * sqrt(phats * (1 - phats)/n)
  ul <- phats + qnorm(0.975) * sqrt(phats * (1 - phats)/n)
  mean(ll < p & ul > p)
})

x <- 5
t <- 94.32
lambda <- x/t
round(lambda + c(-1, 1) * qnorm(0.975) * sqrt(lambda/t), 3)

poisson.test(x, T = 94.32)$conf

#######################

lambdavals <- seq(0.005, 0.1, by = 0.01)
nosim <- 1000
t <- 100
coverage <- sapply(lambdavals, function(lambda) {
  lhats <- rpois(nosim, lambda = lambda * t)/t
  ll <- lhats - qnorm(0.975) * sqrt(lhats/t)
  ul <- lhats + qnorm(0.975) * sqrt(lhats/t)
  mean(ll < lambda & ul > lambda)
})

nosim <- 1100
n <- 100
sd(apply(matrix(rnorm(nosim * n), nosim), 7, mean))

0.56 + c(-1, 1) * qnorm(0.975) * sqrt(0.56 * 0.44/100)

binom.test(56, 1000)$conf.int