source('../R/generate.R')
####Run in each senario ####
## Set parameter lists
sim_params <- list(
    alpha = c(5, 10),  # Baseline mean
    beta = c(0.1, 0.5),  # Treatment effect
    gamma2 = c(0.1, 0.5),  # Cluster random effect variance
    sigma2 = c(1, 2),  # Within-cluster variance
    B = 1000
)
c1_c2_ratios <- list(
    c(20, 5),  
    c(30, 10)
)

# Run Normal Distribution Setting
set.seed(202412)
all_results <- lapply(seq_along(c1_c2_ratios), function(i) {
    cost <- c1_c2_ratios[[i]]
    c1 <- cost[1]
    c2 <- cost[2]
    result <- run_simulation(sim_params, c1 = c1, c2 = c2, n_sim = 1000, distribution = "normal")
    result <- data.frame(result)
    result$c1 <- c1
    result$c2 <- c2
    result$ratio <- c1 / c2
    return(result)
})
# extract results
all_results <- do.call(rbind, all_results)
all_results<- as.data.frame(lapply(all_results, unlist))
# save data
write.csv(all_results,file = "/Users/fusei/Desktop/24FALL/PHP2550/Project3/normal_simulation.csv")

# Run Poisson Distribution Setting
set.seed(202412)
poi_results <- lapply(seq_along(c1_c2_ratios), function(i) {
    cost <- c1_c2_ratios[[i]]
    c1 <- cost[1]
    c2 <- cost[2]
    result <- run_simulation(sim_params, c1 = c1, c2 = c2, n_sim = 1000, distribution = "poisson")
    result <- data.frame(result)
    result$c1 <- c1
    result$c2 <- c2
    result$ratio <- c1 / c2
    return(result)
})
# extract results
poi_results <- do.call(rbind, poi_results)
poi_results<- as.data.frame(lapply(poi_results, unlist))
# save data
write.csv(poi_results,file = "/Users/fusei/Desktop/24FALL/PHP2550/Project3/poi_simulation.csv")
