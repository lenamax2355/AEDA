context("getClusterAnalysis")
data("iris")
set.seed(1L)
sub = sample.int(150, 20)
iris = iris[sub, ]
test_that("getClusterAnalysis kmeans", {
  clustered = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(iter.max = 15L), scale.num.data = TRUE, method = "cluster.kmeans")
  expectIdentical(class(clustered$cluster.all$cluster.res), "kmeans")
  expect_list(clustered$cluster.all$cluster.diag, min.len = 1L)
  lapply(clustered$cluster.all$cluster.diag, FUN = function(x) {
    expectIdentical(class(x), c("gg", "ggplot"))
  })
  expect_length(clustered$comb.cluster.list, 6L)
})

test_that("getClusterAnalysis pam", {
  clustered = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(), scale.num.data = TRUE, method = "cluster.pam")
  expectIdentical(class(clustered$cluster.all$cluster.res), c("pam", "partition"))
  expect_list(clustered$cluster.all$cluster.diag, min.len = 1L)
  lapply(clustered$cluster.all$cluster.diag, FUN = function(x) {
    expectIdentical(class(x), c("gg", "ggplot"))
  })
  expect_length(clustered$comb.cluster.list, 6L)

  clustered.manhattan = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(metric = "manhattan"), scale.num.data = TRUE, method = "cluster.pam")

  # check if clusters are different -> is par.vals working correctly
  expect_false(isTRUE(all.equal(clustered$cluster.all$cluster.res$clusinfo,
    clustered.manhattan$cluster.all$cluster.res$clusinfo)))
})

test_that("getClusterAnalysis cluster.h", {
  clustered = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(), scale.num.data = TRUE, method = "cluster.h")
  expectIdentical(class(clustered$cluster.all$cluster.res), c("hclust", "hcut", "eclust"))
  expect_list(clustered$cluster.all$cluster.diag, min.len = 1L)
  lapply(clustered$cluster.all$cluster.diag, FUN = function(x) {
    expectIdentical(class(x), c("gg", "ggplot"))
  })
  expect_list(clustered$comb.cluster.list, len = 0L)

  clustered.manhattan = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(hc_metric = "manhattan"), scale.num.data = TRUE, method = "cluster.h")
  # check if clusters are different -> is par.vals working correctly
  expect_false(clustered$cluster.all$cluster.res$dist.method == clustered.manhattan$cluster.all$cluster.res$dist.method)
})

test_that("getClusterAnalysis cluster.h", {
  clustered = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(), scale.num.data = TRUE, method = "cluster.h")
  expectIdentical(class(clustered$cluster.all$cluster.res), c("hclust", "hcut", "eclust"))
  expect_list(clustered$cluster.all$cluster.diag, len = 2L)
  lapply(clustered$cluster.all$cluster.diag, FUN = function(x) {
    expectIdentical(class(x), c("gg", "ggplot"))
  })
  expect_list(clustered$comb.cluster.list, len = 0L)

  clustered.manhattan = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(hc_metric = "manhattan"), scale.num.data = TRUE, method = "cluster.h")
  # check if clusters metric is different -> is par.vals working correctly
  expect_false(clustered$cluster.all$cluster.res$dist.method == clustered.manhattan$cluster.all$cluster.res$dist.method)
})

test_that("getClusterAnalysis cluster.agnes", {
  clustered = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(), scale.num.data = TRUE, method = "cluster.agnes")
  expectIdentical(class(clustered$cluster.all$cluster.res), c("agnes", "twins", "hcut", "eclust"))
  expect_list(clustered$cluster.all$cluster.diag, len = 2L)
  lapply(clustered$cluster.all$cluster.diag, FUN = function(x) {
    expectIdentical(class(x), c("gg", "ggplot"))
  })
  expect_list(clustered$comb.cluster.list, len = 0L)

  clustered.k6 = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(k = 6L), scale.num.data = TRUE, method = "cluster.agnes")
  # check if clusters are different -> is par.vals working correctly
  expect_false(clustered$cluster.all$cluster.res$nbclust == clustered.k6$cluster.all$cluster.res$nbclust)
})

test_that("getClusterAnalysis cluster.diana", {
  clustered = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(), scale.num.data = TRUE, method = "cluster.diana")
  expectIdentical(class(clustered$cluster.all$cluster.res), c("diana", "twins", "hcut", "eclust"))
  expect_list(clustered$cluster.all$cluster.diag, len = 2L)
  lapply(clustered$cluster.all$cluster.diag, FUN = function(x) {
    expectIdentical(class(x), c("gg", "ggplot"))
  })
  expect_list(clustered$comb.cluster.list, len = 0L)

  clustered.k2 = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(k = 2L), scale.num.data = TRUE, method = "cluster.diana")
  # check if clusters are different -> is par.vals working correctly
  expect_false(clustered$cluster.all$cluster.res$nbclust == clustered.k2$cluster.all$cluster.res$nbclust)
})

test_that("getClusterAnalysis cluster.kkmeans", {
  clustered = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(centers = 2L), scale.num.data = TRUE, method = "cluster.kkmeans")
  expectIdentical(class(clustered$cluster.all$cluster.res)[1], "specc")
  expect_list(clustered$cluster.all$cluster.diag, len = 0L)
  expect_list(clustered$comb.cluster.list, len = 6L)

  clustered.kernel = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(kernel = "vanilladot", centers = 2L),
    scale.num.data = TRUE, method = "cluster.kkmeans")
  # check if clusters are different -> is par.vals working correctly
  expect_false(isTRUE(all.equal(clustered$cluster.all$cluster.res,
    clustered.kernel$cluster.all$cluster.res)))
})

test_that("getClusterAnalysis cluster.dbscan", {
  clustered = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(eps = 0.6), scale.num.data = TRUE, method = "cluster.dbscan")
  expectIdentical(class(clustered$cluster.all$cluster.res), c("dbscan_fast", "dbscan"))
  expect_list(clustered$cluster.all$cluster.diag, len = 0L)
  expect_list(clustered$comb.cluster.list, len = 6L)

  clustered.minpts = getClusterAnalysis(data = iris, cluster.cols = NULL,
    num.features = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
    random.seed = 1L, par.vals = list(eps = 0.6, minPts = 2L), scale.num.data = TRUE, method = "cluster.dbscan")
})
