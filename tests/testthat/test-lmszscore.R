context("test-lmszscore.R")

mydf <- data.frame(  age = c(10.2,11.4,9.7,2.3,14.2,18.2,19.4,13.0),
                     sex = rep(c("female","male"),4),
                     bmi = c(20.1,27.3,15.0,18.2,17.4,23.9,21.2,17.9))

lmsref <- data.frame(age = seq(1,20,0.5),
                     L = seq(0.1,-2,length.out = 39),
                     M = seq(13,22,length.out = 39),
                     S = seq(0.09,0.2,length.out = 39))


# Check if calculations are correct
test_that("Test normal functionality", {
expect_equal(round(lmszscore(mydf = mydf, sexcat = "female", sex = "sex", age = "age", var = "bmi" , lmsref = lmsref)[1],2), 0.96)
expect_equal(round(lmszscore(mydf = mydf, sexcat = "male", sex = "sex", age = "age", var = "bmi" , lmsref = lmsref)[1],2), 2.26)
})


# Check errors
expect_error(lmszscore(lmsref = lmsref), "Please give a dataset. For more information use ?lmszscore", fixed = TRUE)
expect_error(lmszscore(mydf = mydf, lmsref ), "Please give reference values. For more information use ?lmszscore", fixed = TRUE)
# expect_error(lmszscore(mydf = mydf, lmsref = lmsref, age = "" ), "Please give reference values. For more information use ?lmszscore", fixed = TRUE)
# expect_error(lmszscore(mydf = mydf, lmsref = lmsref, sex = "" ), "Please give reference values. For more information use ?lmszscore", fixed = TRUE)
# expect_error(lmszscore(mydf = mydf, lmsref = lmsref, var = "" ), "Please give reference values. For more information use ?lmszscore", fixed = TRUE)
# if (!("age" %in% colnames(lmsref) & "L" %in% colnames(lmsref) & "M" %in% colnames(lmsref) & "S" %in% colnames(lmsref))) {
#   stop("Refernce data needs to contain columns named age, L, M and S")}
# if (nrow(mydf[mydf[,"sex"] == sexcat,]) == 0) stop(paste0("Column \'", sex, "\' has 0 rows with the category ", sexcat))





