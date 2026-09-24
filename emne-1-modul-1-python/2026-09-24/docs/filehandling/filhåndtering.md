# Filhåndtering i Python

Filhåndtering handler om å åpne, lese, skrive og sjekke filer på disk.

**Python har innebygd støtte for filhåndtering gjennom `open()`-funksjonen og `os`-modulen.**

For å bruke `os`-modulen må vi importere den:

```python
import os
```

---

# 1. Åpne en fil med `open()`

`open()` er den innebygde funksjonen for å åpne filer i Python.

## Syntaks

```python
open(filename, mode, encoding)
```

| Parameter | Beskrivelse | Standard |
|---|---|---|
| `filename` | Stien til filen som skal åpnes. | — |
| `mode` | Hvordan filen skal åpnes (lese, skrive, osv.). | `'r'` |
| `encoding` | Tegnsettet som skal brukes. | Systemstandard |

**Husk:** Bruk alltid `encoding='utf-8'` for å unngå problemer med norske tegn (æ, ø, å).

## Eksempel – lese en fil

```python
file = open('data.txt', 'r', encoding='utf-8')
content = file.read()
file.close()
```

---

# 2. `with`-blokken (anbefalt metode)

Det anbefales å åpne filer med en `with`-blokk. Den lukker filen automatisk, selv om det oppstår en feil.

```python
with open('data.txt', 'r', encoding='utf-8') as file:
    content = file.read()
```

Etter `with`-blokken er filen lukket automatisk.

## Sammenligning

```python
# Without with – must be closed manually
file = open('data.txt', 'r', encoding='utf-8')
content = file.read()
file.close()  # Easy to forget!

# With with – closed automatically
with open('data.txt', 'r', encoding='utf-8') as file:
    content = file.read()
```

**Husk:** Bruk alltid `with open(...)` – det er sikrere og mer lesbart.

---

# 3. Lese fra fil

Det finnes flere måter å lese innholdet i en fil på.

## `read()` – les hele filen

```python
with open('data.txt', 'r', encoding='utf-8') as file:
    content = file.read()
    print(content)
```

## `readlines()` – les alle linjer som en liste

```python
with open('data.txt', 'r', encoding='utf-8') as file:
    lines = file.readlines()

for line in lines:
    print(line.strip())
```

## `for`-løkke – les linje for linje (mest effektivt)

```python
with open('data.txt', 'r', encoding='utf-8') as file:
    for line in file:
        print(line.strip())
```

## Lese med linjenummer: `enumerate()`

```python
with open('data.txt', 'r', encoding='utf-8') as file:
    for idx, line in enumerate(file, start=1):
        print(f"Line {idx}: {line.strip()}")
```

`enumerate()` gir oss linjenummeret (`idx`) og innholdet (`line`) samtidig. `start=1` gjør at tellingen begynner på 1 i stedet for 0.

---

# 4. Skrive til fil

For å skrive til en fil bruker vi modus `'w'` (overskriv) eller `'a'` (legg til).

## Skrive ny fil (overskriv)

```python
with open('result.txt', 'w', encoding='utf-8') as file:
    file.write("This is the first line\n")
    file.write("This is the second line\n")
```

## Legge til i eksisterende fil

```python
with open('log.txt', 'a', encoding='utf-8') as file:
    file.write("New line added\n")
```

**Husk:** Se `filemodes.md` for en fullstendig oversikt over alle tilgjengelige filviste modi.

---

# 5. Sjekke om en fil finnes: `os.path`

Før vi åpner en fil bør vi sjekke at den faktisk finnes. Da unngår vi unødvendige feil.

## `os.path.exists()` – finnes stien?

Returnerer `True` hvis stien (fil eller mappe) eksisterer, ellers `False`.

```python
import os

if os.path.exists('data.txt'):
    print("The file exists!")
else:
    print("File not found.")
```

## `os.path.isfile()` – er det en fil?

Returnerer `True` hvis stien peker på en fil (ikke en mappe).

```python
if os.path.isfile('data.txt'):
    print("It is a file.")
```

## `os.path.isdir()` – er det en mappe?

Returnerer `True` hvis stien peker på en mappe.

```python
if os.path.isdir('data'):
    print("It is a directory.")
```

## Anbefalt rekkefølge for sjekking

```python
filename = 'data.txt'

# 1. Check that the path exists
if not os.path.exists(filename):
    print(f"File not found: '{filename}'")

# 2. Check that it is a file (not a directory)
elif not os.path.isfile(filename):
    print(f"'{filename}' is not a file")

else:
    with open(filename, 'r', encoding='utf-8') as file:
        content = file.read()
```

**Husk:** Selv om `os.path.exists()` er `True`, betyr det ikke nødvendigvis at det er en fil — det kan også være en mappe.

---

# 6. Arbeide med filstier: `os.path`

`os.path` inneholder mange nyttige funksjoner for å arbeide med filstier.

| Funksjon | Beskrivelse | Eksempel |
|---|---|---|
| `os.path.exists(path)` | Sjekker om stien finnes. | `os.path.exists('data.txt')` → `True/False` |
| `os.path.isfile(path)` | Sjekker om stien er en fil. | `os.path.isfile('data.txt')` → `True/False` |
| `os.path.isdir(path)` | Sjekker om stien er en mappe. | `os.path.isdir('data')` → `True/False` |
| `os.path.dirname(path)` | Returnerer mappedelen av stien. | `os.path.dirname('/data/file.txt')` → `'/data'` |
| `os.path.basename(path)` | Returnerer filnavndelen av stien. | `os.path.basename('/data/file.txt')` → `'file.txt'` |
| `os.path.abspath(path)` | Returnerer absolutt sti. | `os.path.abspath('file.txt')` → `'/home/user/file.txt'` |
| `os.path.realpath(path)` | Returnerer absolutt sti med symboliske lenker løst opp. | `os.path.realpath(__file__)` |
| `os.path.join(a, b)` | Slår sammen stier på tvers av operativsystem. | `os.path.join('data', 'file.txt')` → `'data/file.txt'` |

## Eksempel: `os.path.dirname()` og `os.path.basename()`

```python
path = '/users/alice/project/data.txt'

print(os.path.dirname(path))   # /users/alice/project
print(os.path.basename(path))  # data.txt
```

## Eksempel: `os.path.join()`

```python
folder = 'data'
filename = 'persons.csv'

full_path = os.path.join(folder, filename)
print(full_path)  # data/persons.csv (Linux/Mac) or data\persons.csv (Windows)
```

`os.path.join()` setter inn riktig mappeskilletegn for operativsystemet automatisk.

---

# 7. Endre arbeidsmappe: `os.chdir()`

`os.chdir()` endrer den aktive arbeidsmappen — altså hvilken mappe Python leter i når vi oppgir relative filnavn.

```python
os.chdir('/new/folder')
```

## Hvorfor er dette viktig?

Når vi kjører et skript fra terminalen, er arbeidsmappen der vi kjørte kommandoen fra — ikke nødvendigvis der skriptet ligger.

```
/project/
    src/
        read_data.py
    data/
        persons.csv
```

Hvis vi starter `read_data.py` fra `/project/`, vil Python lete etter `persons.csv` i `/project/` og ikke finne den.

## Løsningen: bytt til skriptets egen mappe

```python
import os

# Find the folder where the script is located
script_dir = os.path.dirname(os.path.realpath(__file__))

# Switch to that folder
os.chdir(script_dir)
```

Nå kan vi bruke relative filnavn som `'../data/persons.csv'` og være sikre på at de fungerer uansett hvor vi starter skriptet fra.

### `__file__`

`__file__` er en innebygd Python-variabel som inneholder stien til det kjørende skriptet.

```python
print(__file__)  # e.g. /project/src/read_data.py
```

---

# 8. Feilhåndtering ved filoperasjoner

Filoperasjoner kan feile av mange grunner. Vi bør alltid håndtere disse feilene.

| Unntak | Når oppstår det? |
|---|---|
| `FileNotFoundError` | Filen finnes ikke. |
| `PermissionError` | Mangler tilgang til å lese eller skrive filen. |
| `UnicodeDecodeError` | Filen kan ikke leses med det valgte tegnsettet. |
| `IsADirectoryError` | Stien peker på en mappe, ikke en fil. |
| `OSError` | Generell systemfeil ved filoperasjon (dekker mange tilfeller). |

## Eksempel – håndtere vanlige feil

```python
filename = 'data.txt'

try:
    with open(filename, 'r', encoding='utf-8') as file:
        content = file.read()

except FileNotFoundError:
    print(f"File not found: '{filename}'")

except PermissionError:
    print(f"No read access: '{filename}'")

except UnicodeDecodeError:
    print(f"Cannot read '{filename}' as UTF-8")

except OSError as error:
    print(f"Error reading '{filename}': {error}")
```

**Husk:** `OSError` er en generell feil som fanger opp mange typer filproblemer. Plasser den alltid sist i `except`-kjeden.

---

# 9. Komplett eksempel: Les en CSV-fil

Vi skal lese en CSV-fil med personer, hoppe over overskriftslinjen, og håndtere feil i dataene.

Filen `persons.csv` ser slik ut:

```text
first_name,last_name,age,gender
Alice,Larsen,30,female
Bob,Johansen,25,male
,Hansen,22,male
```

## Koden

```python
import os


def read_persons(filename: str) -> list[dict]:
    persons: list[dict] = []

    # 1. Check that the path exists
    if not os.path.exists(filename):
        print(f"File not found: '{filename}'")
        return persons

    # 2. Check that it is a file
    if not os.path.isfile(filename):
        print(f"'{filename}' is not a file")
        return persons

    try:
        with open(filename, 'r', encoding='utf-8') as file:
            for idx, line in enumerate(file, start=1):

                # Skip header line
                if idx == 1:
                    continue

                fields = line.rstrip('\n').split(',')

                # Validate that we have 4 fields
                if len(fields) != 4:
                    print(f"Wrong format on line {idx}: {line.strip()}")
                    continue

                first_name, last_name, age_str, gender = fields

                # Validate that all fields have values
                if not all([first_name, last_name, gender]):
                    print(f"Missing data on line {idx}: {line.strip()}")
                    continue

                # Convert age
                try:
                    age = int(age_str)
                except ValueError:
                    print(f"Invalid age on line {idx}: {line.strip()}")
                    continue

                persons.append({
                    'first_name': first_name,
                    'last_name': last_name,
                    'age': age,
                    'gender': gender
                })

    except PermissionError:
        print(f"No access to: '{filename}'")

    except UnicodeDecodeError:
        print(f"Cannot read '{filename}' as UTF-8")

    except OSError as error:
        print(f"Error reading '{filename}': {error}")

    return persons


if __name__ == '__main__':
    # Switch to the script's own folder so relative paths always work
    os.chdir(os.path.dirname(os.path.realpath(__file__)))

    results = read_persons('persons.csv')

    for p in results:
        print(f"{p['first_name']} {p['last_name']}, {p['age']} years old")
```

**Utskrift:**

```text
Missing data on line 4: ,Hansen,22,male
Alice Larsen, 30 years old
Bob Johansen, 25 years old
```

---

# Oppsummering

| Funksjon / Konsept | Beskrivelse |
|---|---|
| `open(file, mode, encoding)` | Åpner en fil. Bruk alltid `encoding='utf-8'`. |
| `with open(...) as file` | Åpner filen og lukker den automatisk etterpå. |
| `enumerate(file, start=1)` | Gir linjenummer og innhold samtidig. |
| `os.path.exists(path)` | Sjekker om stien finnes (fil eller mappe). |
| `os.path.isfile(path)` | Sjekker om stien er en fil. |
| `os.path.isdir(path)` | Sjekker om stien er en mappe. |
| `os.path.dirname(path)` | Returnerer mappedelen av stien. |
| `os.path.basename(path)` | Returnerer filnavnet fra stien. |
| `os.path.join(a, b)` | Slår sammen stier på tvers av operativsystem. |
| `os.path.realpath(__file__)` | Absolutt sti til det kjørende skriptet. |
| `os.chdir(folder)` | Endrer arbeidsmappen. |

## Anbefalt arbeidsflyt for fillesing

1. Bytt til skriptets mappe med `os.chdir(os.path.dirname(os.path.realpath(__file__)))`.
2. Sjekk at filen finnes med `os.path.exists()`.
3. Sjekk at det er en fil med `os.path.isfile()`.
4. Åpne filen med `with open(..., encoding='utf-8')`.
5. Valider dataene linje for linje.
6. Håndter unntak med `except`-blokker.

**Husk:** Alltid sjekk at filen finnes og er av riktig type *før* du åpner den — da unngår du unødvendige unntak og gir brukeren tydelige feilmeldinger.
