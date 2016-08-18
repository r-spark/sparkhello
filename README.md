sparkhello: Scala to Spark - Hello World
================

This is package to demonstrate how [sparklyr](http://github.com/rstudio/sparklyr) can be used to assist in building an [sparkapi](http://github.com/rstudio/sparkapi) extension package that uses Scala code, which is compiled and deployed to Apache Spark.

For instance, suppose that you need to write the following Scala code that needs to deploy to Spark:

``` scala
object HelloWorld {
  def hello() : String = {
    "Hello, world! - From Scala"
  }
}
```

Packaging and deploying this Scala code can be accomplished by reusing the structure of this sample package. The Scala code is stored under `inst/scala` and compiled using the following command which will generate the supporting jars under `inst/java`:

``` r
sparklyr::spark_install(version = "1.6.2")
```

To compile scala code into Spark using sparklyr, installing Scala 2.10 and 2.11 is required. Scala can be downloaded from \[<http://www.scala-lang.org/download/>\] and extracted into, for instance, `/usr/local/scala/scala-2.10.6`.

``` r
sparklyr::compile_package_jars()
```

    ## ==> using scalac 2.10.6

    ## ==> building against Spark 1.6.1

    ## ==> building 'sparkhello-1.6-2.10.jar' ...

    ## ==> '/usr/local/scala/scala-2.10.6/bin/scalac' -optimise '/Users/javierluraschi/RStudio/spark.hello/inst/scala/hello.scala'

    ## ==> '/usr/bin/jar' cf '/Users/javierluraschi/RStudio/spark.hello/inst/java/sparkhello-1.6-2.10.jar' .

    ## ==> sparkhello-1.6-2.10.jar successfully created

    ## ==> using scalac 2.11.8

    ## ==> building against Spark 2.0.0

    ## ==> building 'sparkhello-2.0-2.11.jar' ...

    ## ==> '/usr/local/scala/scala-2.11.8/bin/scalac' -optimise '/Users/javierluraschi/RStudio/spark.hello/inst/scala/hello.scala'

    ## ==> '/usr/bin/jar' cf '/Users/javierluraschi/RStudio/spark.hello/inst/java/sparkhello-2.0-2.11.jar' .

    ## ==> sparkhello-2.0-2.11.jar successfully created

Once the code is compiled as jars, you can make use of it on your own R functions using `invoke` and `invoke_static`:

``` r
spark_hello <- function(sc) {
  sparklyr::invoke_static(sc, "SparkHello.HelloWorld", "hello")
}
```

After building this package, others using `sparklyr` will be able to use your extension as well:

``` r
library(sparklyr)
library(sparkhello)

sc <- spark_connect(master = "local")
spark_hello(sc)
```

    ## [1] "Hello, world! - From Scala"

``` r
spark_disconnect(sc)
```

You can learn more about sparklyr from [spark.rstudio.com](http://spark.rstudio.com/)
