# AdStax Spark Job Manager

The AdStax Spark Job Manager is a gem to manager Spark jobs running in an AdStax
cluster.

## Installation

### From RubyGems

Make sure you have [ruby][ruby-install] (at least v2.0.0) installed, and just
run:

    $ gem install adstax-spark-job-manager

[ruby-install]: https://www.ruby-lang.org/en/documentation/installation/

### From source

Clone this repo and build the gem:

    $ git clone git://github.com/velocidi/adstax-spark-job-manager.git
    $ gem build adstax-spark-job-manager.gemspec
    $ gem install adstax-spark-job-manager-0.2.0.gem

## Usage

The AdStax Spark Job Manager publishes an `adstax-spark-job-manager` binary,
which provides a set of utilities to submit, kill and query the status of Spark
jobs running on an AdStax cluster. See the help for the command (running it with
`-h`) for more details.

The methods available are `submit`, `kill`, `status` or `log`. To submit a job,
one has to provide the task with the `--adstax-host` parameter (pointing to
where the AdStax instance is running), a `--jar` parameter pointing to a bundled
jar with your application, all required dependencies, and which includes at
least one implementation of `eu.shiftforward.adstax.spark.SparkJob`. Note that
you don't need to bundle the `spark-core` dependency, as it will be provided at
runtime. The `--job` parameter should be the fully qualified name of the class
extending `eu.shiftforward.adstax.spark.SparkJob` and which is going to be used
as the Spark job to run. Everything following the required parameters will be
used as arguments for the `SparkJob`. For example, in order to submit the
`SparkPI` example, one can use the following command:

```
$ adstax-spark-job-manager submit --adstax-host sample-adstax-instance.dev.adstax.io --jar http://s3.amazonaws.com/shiftforward-public/bin/spark/adstax-spark-examples-1.0.jar --job eu.shiftforward.adstax.spark.examples.SparkPi 100
```

This command should return information about the submission, for example:

```
{
  "action" : "CreateSubmissionResponse",
  "serverSparkVersion" : "2.0.0-SNAPSHOT",
  "submissionId" : "driver-20160713161243-0002",
  "success" : true
}
```

You can now use the returned submission id to query the status of the job, as
well as list its standard output. In order to query the status of the job, use
the `status` command:

```
$ adstax-spark-job-manager status --adstax-host sample-adstax-instance.dev.adstax.io --submission-id driver-20160713161243-0002
{
  "action" : "SubmissionStatusResponse",
  "driverState" : "FINISHED",
  "message" : "task_id {\n  value: \"driver-20160713161243-0002\"\n}\nstate: TASK_FINISHED\nmessage: \"Command exited with status 0\"\nslave_id {\n  value: \"9f18159e-ebe9-4a70-89e1-9774adf2cdd6-S9\"\n}\ntimestamp: 1.468426400438861E9\nexecutor_id {\n  value: \"driver-20160713161243-0002\"\n}\nsource: SOURCE_EXECUTOR\n11: \"A\\371\\330\\365+\\027Ds\\237\\243\\\"\\317\\276\\353\\363\\367\"\n13: \"\\n\\036\\022\\f10.0.174.173*\\016\\022\\f10.0.174.173\"\n",
  "serverSparkVersion" : "2.0.0-SNAPSHOT",
  "submissionId" : "driver-20160713161243-0002",
  "success" : true
}
```

The `log` command allows you to output the stdout and stderr of the job's
driver. You can hide the stderr with the `--hide-stderr` command and keep
tailing the output with the `--follow` command:

```
$ adstax-spark-job-manager log --adstax-host sample-adstax-instance.dev.adstax.io --submission-id driver-20160713161243-0002 --hide-stderr --follow
Registered executor on ec2-54-87-240-29.compute-1.amazonaws.com
Starting task driver-20160713161243-0002
Forked command at 22260
sh -c 'cd spark-2*;  bin/spark-submit --name eu.shiftforward.adstax.spark.SparkJobRunner --master mesos://zk://zk.sample-adstax-instance.dev.adstax.io:2181/mesos --driver-cores 1.0 --driver-memory 1024M --class eu.shiftforward.adstax.spark.SparkJobRunner --conf spark.driver.supervise=false --conf spark.app.name=eu.shiftforward.adstax.spark.SparkJobRunner --conf spark.es.port=49200 --conf spark.es.nodes=localhost --conf spark.mesos.coarse=false --conf spark.executor.uri=https://s3.amazonaws.com/shiftforward-public/bin/spark/spark-2.0.0-SNAPSHOT-bin-2.4.0.tgz ../adstax-spark-examples-1.0.jar --job eu.shiftforward.adstax.spark.examples.SparkPi 100'
Pi is roughly 3.1407
Command exited with status 0 (pid: 22260)
```

The `kill` command allows you to cancel and kill an ongoing job. Killing already
finished jobs has no effect:

```
$ adstax-spark-job-manager kill --adstax-host sample-adstax-instance.dev.adstax.io --submission-id driver-20160713161243-0002
{
  "action" : "KillSubmissionResponse",
  "message" : "Driver already terminated",
  "serverSparkVersion" : "2.0.0-SNAPSHOT",
  "submissionId" : "driver-20160713161243-0002",
  "success" : false
}
```
