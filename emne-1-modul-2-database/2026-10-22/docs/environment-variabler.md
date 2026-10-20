# Environment-variabler i Python

## Hva er en environment-variabel?

En environment-variabel er en verdi med et navn som et program kan lese når det kjører. Operativsystemet kan sette slike verdier, men i dette prosjektet bruker vi en lokal `.env`-fil som et praktisk sted å lagre dem.

Tenk på Python-filen som oppskriften og `.env`-filen som de personlige innstillingene. Oppskriften kan alle i gruppen bruke, mens hver student kan ha et eget databasepassord.

For en MySQL-tilkobling trenger programmet blant annet disse verdiene:

| Variabel | Betydning | Eksempel |
| --- | --- | --- |
| `USER_NAME` | MySQL-brukernavn | `root` |
| `PASSWORD` | Passordet til MySQL-brukeren | ditt eget passord |
| `DATABASE` | Databasen programmet kobler til | `school` |
| `PORT` | Porten MySQL lytter på | `3306` |

> `PASSWORD` er hemmelig informasjon. Ikke del det i chat, skjermbilder eller Git-repositorier.

## Hvorfor bruker vi environment-variabler?

### Vi beskytter hemmeligheter

Et passord skrevet direkte i en Python-fil blir lett delt når filen sendes til en medstudent eller lastes opp til GitHub. Hvis passordet ligger i `.env`, kan vi utelate denne filen fra Git og dele koden uten hemmeligheten.

### Vi skiller kode fra konfigurasjon

Koden for å koble til databasen er lik på alle maskiner. Verdiene varierer: du kan ha et annet brukernavn, passord eller port enn en medstudent. Når verdiene ligger utenfor koden, slipper vi å endre Python-filen hver gang miljøet endrer seg.

### Vi forbereder oss på ekte applikasjoner

En applikasjon har ofte ulike innstillinger for utvikling, testing og drift. Environment-variabler gjør det mulig å bruke samme kode mot flere miljøer uten å publisere produksjonspassord i kildekoden.

## Opprett en lokal `.env`-fil

Følg disse stegene i mappen `emne-1-modul-2-database\2026-10-22\src\python`:

1. Opprett en fil som heter `.env`.
2. Legg inn dine egne databaseverdier, én variabel per linje:

   ```dotenv
   USER_NAME=root
   PASSWORD=bytt-til-ditt-eget-passord
   DATABASE=school
   PORT=3306
   ```

3. Lagre filen uten anførselstegn rundt vanlige verdier.
4. Kontroller at `.env` ikke lastes opp til Git. Legg `.env` i `.gitignore` dersom prosjektet bruker Git.

`.env` ligger lokalt på din maskin. Den følger ikke automatisk med når du deler Python-filene. Den som skal kjøre prosjektet, må derfor opprette sin egen `.env`-fil.

## Les variablene i Python

Python kan lese environment-variabler med standardbiblioteket `os`. Biblioteket `python-dotenv` leser først `.env`-filen og gjør verdiene tilgjengelige for `os.getenv()`.

Installer biblioteket i det aktive virtuelle miljøet:

```powershell
python -m pip install python-dotenv
```

Bruk deretter denne koden:

```python
import os

from dotenv import load_dotenv

load_dotenv()

database_name = os.getenv("DATABASE")
database_port = os.getenv("PORT")

print(database_name)
print(database_port)
```

`load_dotenv()` leser `.env`-filen. `os.getenv("DATABASE")` henter verdien som hører til navnet `DATABASE`. Python mottar environment-variabler som tekst, derfor må vi gjøre om porten til et tall når MySQL-biblioteket forventer et heltall:

```python
port = int(os.getenv("PORT", "3306"))
```

Det andre argumentet, `"3306"`, er en standardverdi som brukes dersom `PORT` ikke finnes.

## Koble til MySQL med variablene

Eksempelet nedenfor viser hvordan verdiene kan brukes i en databaseforbindelse. Det forutsetter at `mysql-connector-python` og `python-dotenv` er installert.

```python
import os

import mysql.connector
from dotenv import load_dotenv

load_dotenv()

connection = mysql.connector.connect(
    host="localhost",
    user=os.getenv("USER_NAME"),
    password=os.getenv("PASSWORD"),
    database=os.getenv("DATABASE"),
    port=int(os.getenv("PORT", "3306")),
)

print("Tilkoblingen virker.")
connection.close()
```

Navnene i `os.getenv()` må være identiske med navnene i `.env`-filen. Hvis du skriver `USER_NAME` i `.env`, men `USERNAME` i Python, får programmet ikke brukernavnet.

## Sjekk at nødvendige verdier finnes

`os.getenv()` returnerer `None` når en variabel mangler. Oppdag feilen tidlig med en tydelig kontroll før du kobler til databasen:

```python
import os

from dotenv import load_dotenv

load_dotenv()

required_variables = ["USER_NAME", "PASSWORD", "DATABASE"]
missing_variables = [
    name for name in required_variables if not os.getenv(name)
]

if missing_variables:
    names = ", ".join(missing_variables)
    raise RuntimeError(f"Mangler verdier i .env: {names}")
```

Da får du en konkret feilmelding dersom du har glemt en verdi eller lagt `.env`-filen i feil mappe.

## Vanlige feil

| Problem | Sjekk dette |
| --- | --- |
| `None` eller manglende variabel | Kontroller navnet i både `.env` og `os.getenv()`. |
| `ModuleNotFoundError: No module named 'dotenv'` | Aktiver virtuelt miljø og installer `python-dotenv`. |
| `ValueError` ved `int(...)` | Skriv bare et tall i `PORT`, for eksempel `3306`. |
| `Access denied for user` | Kontroller `USER_NAME` og `PASSWORD`. |
| `.env` blir delt med Git | Legg `.env` i `.gitignore` og fjern den fra Git før du deler prosjektet. |

## Oppsummering

Environment-variabler holder konfigurasjon og hemmeligheter utenfor Python-koden. I dette prosjektet leser `load_dotenv()` verdiene fra `.env`, og `os.getenv()` henter dem når programmet kobler seg til MySQL. Dette gjør koden tryggere å dele og enklere å bruke på ulike maskiner.

Se også [oppsett av Python og MySQL](python-mysql-oppsett.md) for å installere bibliotekene og teste tilkoblingen.
