
if(!require(effectsize)){
  install.packages('effectsize')
}

##### Colours
grn <- "#16a085"
grn_dk <- "#1b7742"
blu <- "#5c97bf"
blu_dk <- "#34415e"
mag <- "#b381b3"
mag_dk <- "#886288"
gry <- "#939393"
gry_dk <- "#545454"
ylw <- "#aa8f00"
ylw_dk <- "#634806"
ong <- "#d47500"
ong_dk <- "#d35400"
red <- "#ef4836"
red_dk <- "#b50000"


#### Functions

round_p <- function(x, dp = 3){
  if(x < 0.001){
    "< .001"
  } else if(x < 0.01) {
    "< .01"
  } else {
    paste0("= ", round(x, dp))
  }
}



report_f <- function(x, index = 2, dp = 2){
  last <- length(x$Df)

  paste0("*F*(", x$Df[index], ", ", x$Df[last], ") = ", round(x$`F value`[index], dp), ", *p* ", round_p(x$`Pr(>F)`[index]))
}


report_omega <- function(model, index = 1, dp = 2, partial = FALSE){
  if(isTRUE(partial)){
    omega <- "$ \\omega^2_p $"
    } else {
    omega <- "$ \\omega^2 $"
    }

  x <- effectsize::omega_squared(model, ci = 0.95, partial = partial)
  x <- x[index, ]

  paste0(omega, " = ", round(x$Omega2, dp), ", 95% CI [", round(x$CI_low, dp), ", ",  round(x$CI_high, dp),  "]")
}
