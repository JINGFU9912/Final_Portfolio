library(lme4) 
library(dplyr) 
####Function belows ####
#' @title Get Feasible (G, R) Combinations Under Budget Constraint
#' @description Enumerates feasible combinations of cluster size (G) and replication per cluster (R) under a given budget constraint.
#' @param B Numeric. Total budget available.
#' @param c1 Numeric. Cost per cluster.
#' @param c2 Numeric. Cost per replication within a cluster.
#' @param max_G Numeric. Maximum number of clusters. Default is 1000.
#' @param max_R Numeric. Maximum number of replications per cluster. Default is 1000.
#' @param min_G Numeric. Minimum number of clusters. Default is 10.
#' @param min_R Numeric. Minimum number of replications per cluster. Default is 2.
#' @return A data frame of feasible combinations of G and R under the budget constraint.
#' @export
get_feasible_combinations <- function(B, c1, c2, max_G = 1000, max_R = 1000, min_G = 10, min_R = 2) {
    feasible <- expand.grid(G = min_G:max_G, R = min_R:max_R) %>%
        mutate(cost = G * c1 + G * (R - 1) * c2) %>%
        filter(cost == B)
    return(feasible)
}

#' @title Generate Simulated Data
#' @description Simulates clustered data based on specified parameters and distribution.
#' @param alpha Numeric. Fixed effect intercept.
#' @param beta Numeric. Fixed effect of treatment.
#' @param gamma2 Numeric. Variance of the cluster-level random effects.
#' @param sigma2 Numeric. Variance of the individual-level errors.
#' @param G Numeric. Number of clusters.
#' @param R Numeric. Number of replications per cluster.
#' @param distribution Character. Distribution of the outcome ("normal" or "poisson"). Default is "normal".
#' @return A data frame of simulated data with columns for cluster, treatment, and outcome.
#' @export
generate_data <- function(alpha, beta, gamma2, sigma2, G, R, distribution = "normal") {
    # Generate cluster-level random effects/ epsilon
    cluster_effect <- rnorm(G, mean = 0, sd = sqrt(gamma2)) #epsilon
    treatment <- rbinom(G, 1, 0.5)
    if(length(unique(treatment)) == 1){
        ## avoid all same treatment
        k <- unique(treatment)
        treatment[sample(G,1,prob = rep(1, G))] <- 1 - k
    }
    data <- do.call(rbind, lapply(1:G, function(i) {
        mu <- if (distribution == "normal") {
            alpha + beta * treatment[i] + cluster_effect[i]
        } else {
            exp(alpha + beta * treatment[i] + cluster_effect[i]) 
        }
        y <- if (distribution == "normal") {
            rnorm(R, mean = mu, sd = sqrt(sigma2))
        } else {
            rpois(R, lambda = mu)
        }
        data.frame(cluster = i, treatment = treatment[i], y = y)
    }))
    
    return(data)
}

#' @title Fit a Model to Simulated Data
#' @description Fits a linear mixed model or generalized linear mixed model to simulated data.
#' @param data Data frame. The simulated data.
#' @param distribution Character. Distribution of the outcome ("normal" or "poisson"). Default is "normal".
#' @return A named numeric vector containing the estimated treatment effect (`beta_hat`) and its standard error (`se_beta`).
#' @export
fit_model <- function(data, distribution = "normal") {
    if (distribution == "normal") {
        model <- lmer(y ~ treatment + (1 | cluster), data = data)
    } else {
        # glm for Poisson
        model <- glmer(y ~ treatment + (1 | cluster), data = data, family = poisson(link = "log"))
    }
    
    est_beta <- fixef(model)["treatment"]  # Extract treatment effect estimate
    se_beta <- sqrt(vcov(model)["treatment", "treatment"])  # Extract standard error
    return(c(beta_hat = est_beta, se_beta = se_beta))
}

#' @title Calculate Simulation Performance Measures
#' @description Calculates performance metrics including bias, standard error, and coverage probability for a simulation.
#' @param sim_results Data frame. Simulation results with columns for `beta_hat` and `se_beta`.
#' @param true_beta Numeric. True value of the treatment effect.
#' @return A data frame containing bias, standard error, and coverage probability.
#' @export
calculate_performance <- function(sim_results, true_beta) {
    bias <- mean(sim_results$beta_hat) - true_beta
    se <- sd(sim_results$beta_hat)
    coverage <- mean((sim_results$beta_hat - 1.96 * sim_results$se_beta <= true_beta) &
                         (sim_results$beta_hat + 1.96 * sim_results$se_beta >= true_beta))
    return(data.frame(bias = bias, se = se, coverage = coverage))
}

#' @title Run Simulation Across Parameter Combinations
#' @description Runs a simulation study across multiple parameter combinations and calculates performance metrics.
#' @param sim_params List. Simulation parameters including `B`, `alpha`, `beta`, `gamma2`, and `sigma2`.
#' @param c1 Numeric. Cost per cluster.
#' @param c2 Numeric. Cost per replication within a cluster.
#' @param n_sim Integer. Number of simulations to run for each parameter combination. Default is 1000.
#' @param distribution Character. Distribution of the outcome ("normal" or "poisson"). Default is "normal".
#' @return A data frame containing performance metrics for each parameter combination.
#' @export
run_simulation <- function(sim_params, c1, c2,  n_sim = 1000, distribution = "normal") {
    feasible_combinations <- get_feasible_combinations(sim_params$B, c1, c2)
    results <- list()
    param_grid <- expand.grid(sim_params$alpha, sim_params$beta, sim_params$gamma2, sim_params$sigma2)
    param_grid <- do.call(rbind, lapply(1:nrow(feasible_combinations), function(i) {
        cbind(param_grid, G = feasible_combinations$G[i], R = feasible_combinations$R[i])
    }))
    colnames(param_grid) <- c("alpha", "beta", "gamma2", "sigma2", "G","R")
    
    for (i in 1:nrow(param_grid)) {
        params <- param_grid[i, ]
        sim_results <- replicate(n_sim, {
            data <- generate_data(params$alpha, params$beta, params$gamma2,
                                  params$sigma2, params$G, params$R, distribution = distribution)
            fit_model(data, distribution = distribution)
        }, simplify = FALSE)
        sim_results <- do.call(rbind, sim_results)
        colnames(sim_results) <- c("beta_hat","se_beta")
        sim_results <- data.frame(sim_results)
        performance <- calculate_performance(sim_results, params$beta)
        results[[i]] <- c(params, performance)
    }
    
                            
    return(do.call(rbind, results))
}
