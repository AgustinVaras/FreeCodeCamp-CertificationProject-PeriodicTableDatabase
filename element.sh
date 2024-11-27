#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  #If no execution argument
  echo "Please provide an element as an argument."
else
  #We check if the parameter is a number to know what type of query to use
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    SELECT_ELEMENT_RESULT=$($PSQL "
      SELECT 
        atomic_number, 
        e.name, 
        e.symbol, 
        t.type, 
        p.atomic_mass, 
        p.melting_point_celsius, 
        p.boiling_point_celsius 
      FROM 
        properties p 
      INNER JOIN
        elements e 
        USING(atomic_number) 
      INNER JOIN 
        types t 
      ON 
        p.type_id = t.type_id
      WHERE 
        atomic_number = $1; " 
    );

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
      SELECT_ELEMENT_RESULT=$($PSQL "
      SELECT 
        atomic_number, 
        e.name, 
        e.symbol, 
        t.type, 
        p.atomic_mass, 
        p.melting_point_celsius, 
        p.boiling_point_celsius 
      FROM 
        properties p 
      INNER JOIN
        elements e 
        USING(atomic_number) 
      INNER JOIN 
        types t 
      ON 
        p.type_id = t.type_id
      WHERE 
        e.symbol = '$1'; " 
      ); 

    else
      SELECT_ELEMENT_RESULT=$($PSQL "
        SELECT 
          atomic_number, 
          e.name, 
          e.symbol, 
          t.type, 
          p.atomic_mass, 
          p.melting_point_celsius, 
          p.boiling_point_celsius 
        FROM 
          properties p 
        INNER JOIN
          elements e 
          USING(atomic_number) 
        INNER JOIN 
          types t 
        ON 
          p.type_id = t.type_id
        WHERE 
          e.name = '$1'; " 
      );

    fi

  fi
  if [[ -z $SELECT_ELEMENT_RESULT ]]
    then
      echo "I could not find that element in the database."
    else
      echo $SELECT_ELEMENT_RESULT | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done 
  fi  
fi