#' @title Combinations
#' @description Compute number of combinations
#' @param n number of trials
#' @param k number of successes
#' @return number of combinations
#' @export
#' @examples
#'  bin_choose(n = 5, k = 2)
#'  bin_choose(10, 3)
#'  bin_choose(4, 4)
bin_choose <- function(n, k) {
  if (any(n < k)) {
    stop("n cannot be greater than k")
  }
  numerator <- factorial(n)
  denominator <- factorial(k) * factorial(n-k)
  return(numerator / denominator)
}


# private function to check number of trials
check_trials <- function(n) {
  if (length(n) != 1) {
    stop('invalid length for number of trials')
  }
  if (is.na(n)) {
    stop('invalid missing value for number of trials')
  }
  if ((n %% 1) != 0) {
    stop('n must be a non-negative integer')
  } else if (n < 0) {
    stop('n must be a non-negative integer')
  }
  TRUE
}


# private function to check probability
check_prob <- function(p) {
  if (length(p) != 1) {
    stop('probability must be of length 1')
  }
  if (is.na(p)) {
    stop('invalid missing value for probability')
  }
  if (p < 0 | p > 1) {
    stop('probability must be a number between 0 and 1')
  }
  TRUE
}


# private function to check successes
check_success <- function(success, trials) {
  if (any(success > trials)) {
    stop('success values cannot be greater than trials')
  }
  TRUE
}


#' @title Binomial Probability
#' @description Computes the binomial probability
#' @param success number of successes
#' @param trials number of trials
#' @param prob probability of success
#' @return probability value
#' @seealso \code{\link{bin_distribution}}, \code{\link{bin_cumulative}}
#' @export
#' @examples
#' bin_probability(2, 5, 0.5)
#' bin_probability(2, 5, 0.5)
#' bin_probability(1:4, 5, 0.8)
bin_probability <- function(success, trials, prob) {
  # check inputs
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)

  n <- trials
  k <- success
  p <- prob
  bin_choose(n, k) * p^k * ((1-p)^(n-k))
}


#' @title Binomial Distribution
#' @description Computes binomial distribution
#' @param trials number of trials
#' @param prob probability
#' @return data frame with the probability distribution
#' @seealso \code{\link{bin_cumulative}}
#' @export
#' @examples
#' dis <- bin_distribution(trials = 5, prob = 0.5)
#' dis
#'
#' plot(dis)
bin_distribution <- function(trials, prob) {
  p <- bin_probability(0:trials, trials, prob)

  distrib <- data.frame(
    success = 0:trials,
    probability = p
  )
  class(distrib) <- c("bindis", "data.frame")
  return(distrib)
}


#' @export
plot.bindis <- function(x, ...) {
  barplot(x$probability, names.arg = x$success, border = NA, las = 1,
          xlab = "successes", ylab = "probability", ...)
}


#' @title Binomial Cumulative Distribution
#' @description Computes binomial distribution
#' @param trials number of trials
#' @param prob probability
#' @return data frame with the probability distribution
#' @seealso \code{\link{bin_distribution}}
#' @export
#' @examples
#' cum <- bin_cumulative(trials = 5, prob = 0.5)
#' cum
#'
#' plot(cum)
bin_cumulative <- function(trials, prob) {
  n <- trials
  p <- prob
  probs <- bin_probability(0:n, n, prob)

  tbl <- data.frame(
    success = 0:n,
    probability = probs,
    cumulative = cumsum(probs)
  )
  class(tbl) <- c("bincum", "data.frame")
  return(tbl)
}


#' @export
plot.bincum <- function(x, ...) {
  plot(x$success, x$cumulative, las = 1,
       xlab = "successes", ylab = "probability", ...)
  lines(x$success, x$cumulative)
}



#' @title Binomial Random Variable
#' @description Creates a binomial random variable object
#' @param trials number of trials
#' @param prob probability of success
#' @return an object of class \code{"binvar"}
#' @export
#' @examples
#' binex <- bin_variable(10, 0.3)
#' binex
#'
#' summary(binex)
bin_variable <- function(trials, prob) {
  # check inputs
  check_trials(trials)
  check_prob(prob)

  obj <- list(
    trials = trials,
    prob = prob
  )
  class(obj) <- "binvar"
  return(obj)
}


#' @export
print.binvar <- function(x, ...) {
  cat('"Binomial variable"\n\n')
  cat("Paramaters", "\n")
  cat("- number of trials:", x$trials, "\n")
  cat("- prob of success :", x$prob, "\n\n")
  invisible(x)
}



#' @title Binomial Mean (Expected Value)
#' @description Mean of binomial distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return mean or expected value
#' @export
#' @examples
#' bin_mean(10, 0.3)
bin_mean <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_mean(trials, prob)
}

# private function to compute mean of binomial
aux_mean <- function(trials, prob) {
  trials * prob
}



#' @title Binomial Variance
#' @description Variance of binomial distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return variance or expected value
#' @export
#' @examples
#' bin_variance(10, 0.3)
bin_variance <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_variance(trials, prob)
}

# private function to compute variance of binomial
aux_variance <- function(trials, prob) {
  trials * prob * (1 - prob)
}



#' @title Binomial Mode
#' @description Mode of a Binommial Distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return mode of binomial distribution
#' @export
#' @examples
#' bin_mode(10, 0.3)
#' bin_mode(5, 0.5)
bin_mode <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_mode(trials, prob)
}

# private function to compute mode of binomial
aux_mode <- function(trials, prob) {
  m <- as.integer((trials * prob + prob))
  if ((trials %% 2) == 0) { # even trials
    return(m)
  } else { # odd trials
    return(c(m-1, m))
  }
}



#' @title Binomial Skewness
#' @description Skewness of a Binommial Distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return skewness value
#' @export
#' @examples
#' bin_skewness(10, 0.3)
bin_skewness <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_skewness(trials, prob)
}

# private function to compute skewness
aux_skewness <- function(trials, prob) {
  (1 - 2 * prob) / sqrt(trials * prob * (1 - prob))
}



#' @title Binomial Kurtosis
#' @description Kurtosis of a Binommial Distribution
#' @param trials number of trials
#' @param prob probability of success
#' @return kurtosis value
#' @export
#' @examples
#' bin_kurtosis(10, 0.3)
bin_kurtosis <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  aux_kurtosis(trials, prob)
}

# private function to compute kurtosis
aux_kurtosis <- function(trials, prob) {
  (1 - (6 * prob * (1 - prob))) / (trials * prob * (1 - prob))
}



#' @export
summary.binvar <- function(x, ...) {
  obj <- list(
    trials = x$trials,
    prob = x$prob,
    mean = aux_mean(x$trials, x$prob),
    variance = aux_variance(x$trials, x$prob),
    mode = aux_mode(x$trials, x$prob),
    skewness = aux_skewness(x$trials, x$prob),
    kurtosis = aux_kurtosis(x$trials, x$prob)
  )
  class(obj) <- "summary.binvar"
  return(obj)
}


#' @export
print.summary.binvar <- function(x, ...) {
  cat('"Summary Binomial"\n\n')
  cat("Paramaters", "\n")
  cat("- number of trials:", x$trials, "\n")
  cat("- prob of success :", x$prob, "\n\n")
  cat("Measures", "\n")
  cat("- mean    :", x$mean, "\n")
  cat("- variance:", x$variance, "\n")
  cat("- mode    :", x$mode, "\n")
  cat("- skewness:", x$skewness, "\n")
  cat("- kurtosis:", x$kurtosis, "\n\n")
  invisible(x)
}

