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

``` r
sparklyr::spark_compile("SparkHello")
```

    ## ==> using scalac 2.11.8

    ## ==> building against Spark 1.6.2

    ## ==> building 'SparkHello' ...

    ## ==> '/usr/local/bin/scalac' -optimise '/Users/javierluraschi/RStudio/spark.hello/inst/scala/hello.scala'

    ## ==> '/usr/bin/jar' cf '/Users/javierluraschi/RStudio/spark.hello/inst/java/SparkHello' .

    ## ==> SparkHello successfully created

    ## [1] TRUE

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
