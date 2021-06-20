#!/bin/bash
for f in *.xml;
do
echo "Processing ${f%.*} file.."; #truncate the .xml extention and load the xml file for job creation
java -jar jenkins-cli.jar -s http://admin:f6e891122e6c4002ae129d6b1d2fe834@178.154.230.160:8080/ create-job ${f%.*}  < $f
done

