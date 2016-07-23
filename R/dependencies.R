spark_dependencies <- function(spark_version, scala_version, ...) {
  sparkapi::spark_dependency(
    jars = c(
      system.file("java/SparkHello-1.6.1.jar",
                  package = "sparkhello")
    ),
    packages = c(
    )
  )
}

#' @import sparkapi
.onLoad <- function(libname, pkgname) {
  sparkapi::register_extension(pkgname)
}
