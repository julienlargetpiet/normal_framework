normal_gen1 <- function(n_inpt = 100,
                        mean_inpt, 
                        sd_inpt, 
                        offset_proba = 0.01,
                        low_del,
                        accuracy = 0.05){
  intervl <- 0.205 * n_inpt
  offset_val <- (abs(log(0.01 * sd_inpt * (2 * pi) ** 0.5) * 2)) ** 0.5 * sd_inpt
  random_data <- runif(n = n_inpt * 2, min = 0, max = offset_val)
  cur_step <- offset_val / n_inpt
  ref_v <- seq(from = cur_step, to = offset_val, by = cur_step)
  already_v = rep(x = 0, times = length(ref_v))
  rtn_v <- c(1, 2)
  cnt = 1
  ref_sd <- 1
  cur_mean = 0
  cur_lngth = 0
  Cnt = 1
  while (abs(sd(rtn_v) - sd_inpt) > accuracy){
    if (rtn_v[1] == 1 & rtn_v[2] == 2){ rtn_v <- c() }
    while (cur_lngth < (n_inpt / sub_function_1)){ # first function
      cur_time <- random_data[cnt %% length(random_data)]
      cur_max_val <- (1 / (ref_sd * sqrt(2 * pi))) * exp(-(((cur_time / ref_sd) ** 2) / 2))
      min_idx <- which.min(abs(ref_v - cur_time))
      if (already_v[min_idx] < cur_max_val * 2 - low_del){
        if (cnt %% 2 == 0){
          rtn_v <- c(rtn_v, (mean_inpt - cur_mean - cur_time))
        }else{
          rtn_v <- c(rtn_v, (mean_inpt + cur_mean + cur_time))
        }
        cur_lngth = cur_lngth + 1
        if (min_idx - intervl < 1){
          already_v[1:(min_idx + intervl)] = already_v[1:(min_idx + intervl)] + (1 / n_inpt)
        }else if (min_idx + intervl > length(already_v)){
          already_v[(min_idx - intervl):length(already_v)] = already_v[(min_idx - intervl):length(already_v)] + (1 / n_inpt)
        }else{
          already_v[(min_idx - intervl):(min_idx + intervl)] = already_v[(min_idx - intervl):(min_idx + intervl)] + (1 / n_inpt)
        }
      }
      if ((cnt + 1) < length(random_data)){
        cnt = cnt + 1
      }else{
        cnt = 1
      }
    }
    Cnt = Cnt + 1
    already_v[1:length(already_v)] <- 0 
    cur_mean = cur_mean + sub_function_2 # second function
    cur_lngth = 0
  }
  return(rtn_v)
}
