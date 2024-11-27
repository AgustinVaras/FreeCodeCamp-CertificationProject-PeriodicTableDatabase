#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  #If no execution argument
  echo "Please provide an element as an argument."
else
  #Execution logic
  SELECT_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number = $1 " );

  if [[ -z $SELECT_ELEMENT_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
  fi  
fi