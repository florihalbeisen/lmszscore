##' Calculate z scores using LMS values
##'
##' ´lmszscore´ calculates growth and BMI z scores using LMS reference values
##'
##' @title Calculate z scores
##' @param mydf data frame. The data frame needs to have data on age, sex and BMI or height
##' @param sexcat coding of sex for male
##' @param sex column name of sex column e.g. "sex"
##' @param age column name of age column e.g. "age"
##' @param var column name of item e.g. "bmi"
##' @param lmsref LMS reference data. Needed column "age", "L", "M", "S", data needs to be sex specific
##' @return The function returns a vector containing z scores
##'
##' @examples
##' mydf <- data.frame(  age = c(10.2,11.4,9.7,2.3,14.2,18.2,19.4,13.0),
##'                      sex = sample(c("male","female"), size = 8, replace = TRUE),
##'                      bmi = c(20.1,27.3,15.0,18.2,17.4,23.9,21.2,17.9))
##'
##' lmsref <- data.frame(age = seq(1,20,0.5),
##'                         L = seq(0.1,-2,length.out = 39),
##'                         M = seq(13,22,length.out = 39),
##'                         S = seq(0.09,0.2,length.out = 39))
##'
##' lmszscore(mydf = mydf, sexcat = "female", sex = "sex", age = "age", var = "bmi" , lmsref = lmsref)
##'
##' @author Florian Halbeisen
##' @export
lmszscore <- function(mydf, sexcat = 0, sex = "sex", age = "age", var = "bmi" , lmsref){

    # Error handling
    if (missing(lmsref)) stop("Please give reference values. For more information use ?lmszscore")
    if (missing(mydf))   stop("Please give a dataset. For more information use ?lmszscore")
    if (!("age" %in% colnames(lmsref) & "L" %in% colnames(lmsref) & "M" %in% colnames(lmsref) & "S" %in% colnames(lmsref))) {
        stop("Refernce data needs to contain columns named age, L, M and S")}
    if (!(sex %in% colnames(mydf))) stop(paste0("Column \'", sex, "\' not found in ", deparse(substitute(mydf))))
    if (!(age %in% colnames(mydf))) stop(paste0("Column \'", age, "\' not found in ", deparse(substitute(mydf))))
    if (!(var %in% colnames(mydf))) stop(paste0("Column \'", var, "\' not found in ", deparse(substitute(mydf))))
    if (nrow(mydf[mydf[,sex] == sexcat,]) == 0) stop(paste0("Column \'", sex, "\' has 0 rows with the category ", sexcat))

    # setting variables
    ageref <- lmsref$age
    lms    <- c()
    bmiz   <- c()
    mydf <- mydf[mydf[,sex] == sexcat,]

    if (any(is.na(mydf[[age]]))) stop("There are some patients without age at measurment - cannot caculate BMI z-score")

    # Looping trought all entries of the data
    for (i in 1:length(mydf[,age])) {

      # Setting age to max age in LMS references
      if (mydf[i,age] > max(ageref)) {
         mydf[i,age] <- max(ageref)
         warning("Age > max age in LMS refernces - Age set to max LMS reference age")
      }

      # Interpolated l,m,s values
      dif    <- abs(mydf[i,age] - ageref)
      ind    <- rank(dif) %in% c(1,2)

      if (sum(ind, na.rm = TRUE) == 2) {
        lambda <- dif[ind][1]/sum(dif[ind])
        lms    <- (1 - lambda) * lmsref[ind,c("L","M","S")][1, ] + lambda * lmsref[ind,c("L","M","S")][2, ]

      } else if (sum(ind, na.rm = TRUE) == 1) {
        lms    <-  lmsref[ind,c("L","M","S")]

      } else{stop("Error: Invalid number of categories")}

      bmiz <- c(bmiz,((mydf[i,var]/lms$M)^(lms$L) - 1) / (lms$S*lms$L))

    }
    return(bmiz)
}

