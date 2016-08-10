# Hello, world! - From Spark and Scala
#
# This is an example package which compiles
# a hello function in scala and deploys it
# to spark using sparklyr.
#
# You can learn more about sparklyr at:
#
#   http://spark.rstudio.com/
#

#' @import sparklyr
#' @export
spark_hello <- function(sc) {
  sparklyr::invoke_static(sc, "SparkHello.HelloWorld", "hello")
}
