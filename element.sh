#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  #If no execution argument
  echo "Please provide an element as an argument."
#else
  #Execution logic
fi