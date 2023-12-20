#!/bin/sh
echo "Starting app"
cd ../clone
echo "" > spring.log
java -jar target/spring-boot.jar > spring.log &
counter=0
while [ $counter -le 5 ]; do
  sleep 5
  count=$(cat spring.log | grep "Started Application" | wc -l)

  if test "$count" = "1"
  then
    echo "Application has been started"
    counter=6 # on sort de la condition
  else
    counter=$((counter + 1))
    counterror=$(cat spring.log | grep "exception" | wc -l)
    if [ "$counter" = "6" ] || [ "$counterror" = "1" ]
    then
      echo "We have an error while starting the app"
      exit 0
    fi
  fi
done
