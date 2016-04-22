# AdStax Spark Job Manager

Script to manage Spark jobs in an AdStax cluster.

## Installation

To install the AdStax Spark Job Manager gem, just run:

    $ gem install adstax-spark-job-manager -s http://sf:{NEXUS_PASS}@nexus.int.shiftforward.eu/content/repositories/gems/

## Usage

The AdStax Spark Job Manager provides a set of utilities to submit, kill and query the status of Spark jobs running on an AdStax cluster. See the help for the command (running it with `-h`) for more details.

## Development

The `bin` directory contains the scripts to be made available when the gem is installed.

To install the gem locally without sending it to Nexus, run `rake install`.

Publishing in Nexus requires the gem `nexus`. You can publish the gem to Nexus by running `rake publish`. When the `nexus` gem is first used the program will ask for the URL and credentials of the Nexus installation.
