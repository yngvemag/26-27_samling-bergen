from typing import Sequence

import mysql.connector

def query(host: str,
          user: str,
          password: str,
          database: str,
          query_str: str,
          query_parameters_values: list,
          port: int = 3306,
          dictionary: bool = False) -> list[tuple] | list[dict] | Sequence:
    try:

        # trenger kobling til database ...
        # STEP 1
        with mysql.connector.connect(host=host, user=user, password=password, database=database, port=port) as conn:

            # Ved å bruke databasetilkoblingen con, opprettes en "cursor" som vil tillate deg å utføre SQL-spørringer og
            # hente resultater. dictionary=False indikerer at resultatene ikke skal returneres som dictionaries,
            # men som tupler.
            # STEP 2
            with conn.cursor(dictionary=dictionary) as db_cursor:
                # gjennfør spørring
                # STEP 3
                db_cursor.execute(query_str, query_parameters_values)

                # henter resultatene
                # STEP 4a (SELECT)
                result = db_cursor.fetchall()

                return result

    except mysql.connector.DatabaseError as dbErr:
        print(f"Database error: '{dbErr}'")
        return []

def command(host: str,
           user: str,
           password: str,
           database: str,
           command_str: str,
           command_parameters_values: list,
           port: int = 3306) -> bool:
    try:
        # Step 1
        with mysql.connector.connect(host=host, port=port, user=user, password=password, database=database) as conn:
            # Step 2
            with conn.cursor() as db_cursor:
                # Step 3
                db_cursor.execute(command_str, command_parameters_values)

            # Step 4b -> for insert, update og delete -> bekrefte endringer i databasen
            conn.commit()

            return True if db_cursor.rowcount == 1 else False

    except mysql.connector.IntegrityError as intErr:
        print(f"Database IntegrityError error: '{intErr}'")
        return False
    except mysql.connector.DatabaseError as dbErr:
        print(f"Database error: '{dbErr}'")
        return False