#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

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

      if [[ -z $SELECT_ELEMENT_RESULT ]]
      then
        echo "I could not find that element in the database."
      else
        echo $SELECT_ELEMENT_RESULT
      fi
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

      if [[ -z $SELECT_ELEMENT_RESULT ]]
      then
        echo "I could not find that element in the database."
      else
        echo $SELECT_ELEMENT_RESULT
      fi
    fi

  fi  
fi