import sys
import os
from lib import Person

def str_to_age(age: str) -> int:
    try:
        return int(age)
    except ValueError:
        return -1

def write_to_file(filname: str, text: str, mode: str = 'a') -> None:
    try:
        with open(filname, mode, encoding='utf-8') as f:
            f.write(text + '\n')
    except PermissionError:
        print("Har ikke filrettigheter til å skrive til denne filen!")
    except OSError:
        print("Feil ved skriving av fil!")

def read_persons(filename: str) -> list[Person]:

    person_list: list[Person] = []
    try:
        # Vi starter med å lese filen!
        with open(filename,"r",encoding="utf-8") as file_read:
            for idx, line in enumerate(file_read, start=1):

                # hopper over linje
                if idx == 1:
                    continue

                # "Ole,Johansen,44,Mann"
                # ['Ole', 'Johansen', '44', 'Mann']
                person_data_arr = line.rstrip("\n").split(",")

                # 1. Validering: sjekk at vi har 4 felter !!
                if len(person_data_arr) != 4:
                    print(f"Feil format på filen, linjenr: {idx}: linje: {line}")
                    continue

                fname, ename, age_str, gender = person_data_arr

                # cast agt_str -> age
                age = str_to_age(age_str)

                # sjekk at alder er ok
                if age < 0:
                    print(f"Feil i filen, fant ikke alder. Linjenr: {idx}, line: {line}")
                    continue

                # Opprette person objekt
                p = Person(fname, ename, age, gender)

                # Validering: sjekk at alle felter har verdier
                if not all([p.first_name, p.last_name, p.gender]):
                    print(f"Mangler felter. Linjenr: {idx}, line: {line}")
                    continue

                # Sjekk at vi har gyldige verdier for kjønn ('mann', 'kvinne')
                if p.gender.lower() not in ['kvinne', 'mann']:
                    print(f"kjønn uriktig oppgitt: linenr:{idx}, line: {line}")
                    continue

                # Så kan vi legge person i return liste !!
                person_list.append(p)

    except FileNotFoundError:
        print(f"Feil: Fant ikke filen {filename}")
    except OSError as e:
        print(f"Feil ved lesing av filen {filename}: {e}")

    return person_list

def get_age_by_gender(persons: list[Person], gender: str) -> int:
    tot_age = 0
    for p in persons:
        if p.gender.lower() == gender.lower():
            tot_age += p.age

    return tot_age

def get_gender_count(persons: list[Person], gender:str) -> int:
    count = 0
    for p in persons:
        if p.gender.lower() == gender.lower():
            count += 1
    return count

if __name__ == '__main__':
    try:
        # bytt mappe til denne mappen vi kjører i
        os.chdir(os.path.dirname(os.path.realpath(__file__)))

        filename = "persons.csv"

        # Les inn data fra fil!
        results = read_persons(filename)

        # Med funkjoner
        age_men = get_age_by_gender(results, 'mann')
        age_women = get_age_by_gender(results, 'kvinne')
        count_men = get_gender_count(results, 'mann')
        count_women = get_gender_count(results, 'kvinne')

        # Med list comprehension
        age_men2 = sum([p.age for p in results if p.gender.lower() == 'mann'])
        age_women2 = sum([p.age for p in results if p.gender.lower() == 'kvinne'])
        count_men2 = len([p for p in results if p.gender.lower() == 'mann'])
        count_women2 = len([p for p in results if p.gender.lower() == 'kvinne'])

        #for p in results:
        #    print(p)

    except Exception as error:
        print(f"En uventet feil oppstod {e}")
        sys.exit(1)