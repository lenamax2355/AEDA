#' @title Calculates the Correlation Matrix
#'
#' @description
#' makeCorr calculates the correlation matrix with the predefines methode and wrapes an object around it
#'
#' @param corr.task [\code{CorrTask}]\cr
#'   A corrTask Object
#'
#'
#' @return CorrObject
#'
#' @examples
#' corr.task = makeCorrTask(id = "test", data = cars)
#' corr.result = makeCorr(corr.task)
#' corr.result$corr.matrix
#' @import checkmate
#' @import BBmisc
#' @importFrom stats cor
#' @export
makeCorr = function(corr.task){
  assertClass(corr.task, "CorrTask")

  data = corr.task$env$data
  ord = corr.task$features$ord
  # Convert ordered data to integer
  for (string in ord) {
    data[string] = xtfrm(data[string])
  }
  features = unlist(corr.task$features)
  corr.matrix = cor(x = data[, features], method = corr.task$method, use = "na.or.complete")
  corr.task$needed.pkgs = c(corr.task$needed.pkgs, "stats")

  makeS3Obj2("CorrObj", corr.task,
    corr.matrix = corr.matrix)
}

#' @export
# Print fuction for CorrObj Object
print.CorrObj = function(x, ...) {
  catf("Task: %s", x$id)
  catf("Type: %2s", x$type)
  catf("Name of the Data: %s", x$data.name)
  cat("Correlationmatrix: \n")
  print(x$corr.matrix)
}
