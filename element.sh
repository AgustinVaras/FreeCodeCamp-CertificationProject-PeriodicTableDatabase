#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  #If no execution argument
  echo "Please provide an element as an argument."
else
  #We hceck if the parameter is a number to know what type of query to use
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    SELECT_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number = $1 " );

    if [[ -z $SELECT_ELEMENT_RESULT ]]
    then
      echo "I could not find that element in the database."
    else
      echo $SELECT_ELEMENT_RESULT
    fi
  else

    #If it's not a number we check parameter's length to valiate if it's a symbol or the element's name
    if [[ ${#1} -le 2 ]]
    then 
      SELECT_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE symbol = '$1'" )

      if [[ -z $SELECT_ELEMENT_RESULT ]]
      then
        echo "I could not find that element in the database."
      else
        echo $SELECT_ELEMENT_RESULT
      fi
    else
      SELECT_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE name = '$1'" )

      if [[ -z $SELECT_ELEMENT_RESULT ]]
      then
        echo "I could not find that element in the database."
      else
        echo $SELECT_ELEMENT_RESULT
      fi
    fi
  fi  
fi