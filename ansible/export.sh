#! /bin/bash
    SAVEIFS=$IFS
    IFS=$(echo -en "\n\b")
    declare -i j=0
    for i in $(java -jar jenkins-cli.jar -s http://$INVENTORY_HOSTNAME:8080/jenkins list-jobs  --username admin --password f6e891122e6c4002ae129d6b1d2fe834);
    do
    let "j++";
    echo $j;
    if [ $j -gt 283 ] // If you have more jobs do it in chunks as it will terminate in the middle of the process. So Resume your job from where it ends.
     then
    java -jar jenkins-cli.jar -s http://$INVENTORY_HOSTNAME:8080/jenkins get-job --username admin --password f6e891122e6c4002ae129d6b1d2fe834 ${i} > ${i}.xml;
    echo "done";
    fi
    done
