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
open(filnavn, mode, encoding)
```

| Parameter | Beskrivelse | Standard |
|---|---|---|
| `filnavn` | Stien til filen som skal åpnes. | — |
| `mode` | Hvordan filen skal åpnes (lese, skrive, osv.). | `'r'` |
| `encoding` | Tegnsettet som skal brukes. | Systemstandard |

**Husk:** Bruk alltid `encoding='utf-8'` for å unngå problemer med norske tegn (æ, ø, å).

## Eksempel – lese en fil

```python
fil = open('data.txt', 'r', encoding='utf-8')
innhold = fil.read()
fil.close()
```

---

# 2. `with`-blokken (anbefalt metode)

Det anbefales å åpne filer med en `with`-blokk. Den lukker filen automatisk, selv om det oppstår en feil.

```python
with open('data.txt', 'r', encoding='utf-8') as fil:
    innhold = fil.read()
```

Etter `with`-blokken er filen lukket automatisk.

## Sammenligning

```python
# Uten with – må lukkes manuelt
fil = open('data.txt', 'r', encoding='utf-8')
innhold = fil.read()
fil.close()  # Lett å glemme!

# Med with – lukkes automatisk
with open('data.txt', 'r', encoding='utf-8') as fil:
    innhold = fil.read()
```

**Husk:** Bruk alltid `with open(...)` – det er sikrere og mer lesbart.

---

# 3. Lese fra fil

Det finnes flere måter å lese innholdet i en fil på.

## `read()` – les hele filen

```python
with open('data.txt', 'r', encoding='utf-8') as fil:
    innhold = fil.read()
    print(innhold)
```

## `readlines()` – les alle linjer som en liste

```python
with open('data.txt', 'r', encoding='utf-8') as fil:
    linjer = fil.readlines()

for linje in linjer:
    print(linje.strip())
```

## `for`-løkke – les linje for linje (mest effektivt)

```python
with open('data.txt', 'r', encoding='utf-8') as fil:
    for linje in fil:
        print(linje.strip())
```

## Lese med linjenummer: `enumerate()`

```python
with open('data.txt', 'r', encoding='utf-8') as fil:
    for idx, linje in enumerate(fil, start=1):
        print(f"Linje {idx}: {linje.strip()}")
```

`enumerate()` gir oss linjenummeret (`idx`) og innholdet (`linje`) samtidig. `start=1` gjør at tellingen begynner på 1 i stedet for 0.

---

# 4. Skrive til fil

For å skrive til en fil bruker vi modus `'w'` (overskriv) eller `'a'` (legg til).

## Skrive ny fil (overskriv)

```python
with open('resultat.txt', 'w', encoding='utf-8') as fil:
    fil.write("Dette er første linje\n")
    fil.write("Dette er andre linje\n")
```

## Legge til i eksisterende fil

```python
with open('logg.txt', 'a', encoding='utf-8') as fil:
    fil.write("Ny linje lagt til\n")
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
    print("Filen finnes!")
else:
    print("Filen ble ikke funnet.")
```

## `os.path.isfile()` – er det en fil?

Returnerer `True` hvis stien peker på en fil (ikke en mappe).

```python
if os.path.isfile('data.txt'):
    print("Det er en fil.")
```

## `os.path.isdir()` – er det en mappe?

Returnerer `True` hvis stien peker på en mappe.

```python
if os.path.isdir('data'):
    print("Det er en mappe.")
```

## Anbefalt rekkefølge for sjekking

```python
filnavn = 'data.txt'

# 1. Sjekk at stien finnes
if not os.path.exists(filnavn):
    print(f"Finner ikke filen: '{filnavn}'")

# 2. Sjekk at det er en fil (ikke en mappe)
elif not os.path.isfile(filnavn):
    print(f"'{filnavn}' er ikke en fil")

else:
    with open(filnavn, 'r', encoding='utf-8') as fil:
        innhold = fil.read()
```

**Husk:** Selv om `os.path.exists()` er `True`, betyr det ikke nødvendigvis at det er en fil — det kan også være en mappe.

---

# 6. Arbeide med filstier: `os.path`

`os.path` inneholder mange nyttige funksjoner for å arbeide med filstier.

| Funksjon | Beskrivelse | Eksempel |
|---|---|---|
| `os.path.exists(sti)` | Sjekker om stien finnes. | `os.path.exists('data.txt')` → `True/False` |
| `os.path.isfile(sti)` | Sjekker om stien er en fil. | `os.path.isfile('data.txt')` → `True/False` |
| `os.path.isdir(sti)` | Sjekker om stien er en mappe. | `os.path.isdir('data')` → `True/False` |
| `os.path.dirname(sti)` | Returnerer mappedelen av stien. | `os.path.dirname('/data/fil.txt')` → `'/data'` |
| `os.path.basename(sti)` | Returnerer filnavndelen av stien. | `os.path.basename('/data/fil.txt')` → `'fil.txt'` |
| `os.path.abspath(sti)` | Returnerer absolutt sti. | `os.path.abspath('fil.txt')` → `'/home/bruker/fil.txt'` |
| `os.path.realpath(sti)` | Returnerer absolutt sti med symboliske lenker løst opp. | `os.path.realpath(__file__)` |
| `os.path.join(a, b)` | Slår sammen stier på tvers av operativsystem. | `os.path.join('data', 'fil.txt')` → `'data/fil.txt'` |

## Eksempel: `os.path.dirname()` og `os.path.basename()`

```python
sti = '/brukere/alice/prosjekt/data.txt'

print(os.path.dirname(sti))   # /brukere/alice/prosjekt
print(os.path.basename(sti))  # data.txt
```

## Eksempel: `os.path.join()`

```python
mappe = 'data'
filnavn = 'personer.csv'

full_sti = os.path.join(mappe, filnavn)
print(full_sti)  # data/personer.csv (Linux/Mac) eller data\personer.csv (Windows)
```

`os.path.join()` setter inn riktig mappeskilletegn for operativsystemet automatisk.

---

# 7. Endre arbeidsmappe: `os.chdir()`

`os.chdir()` endrer den aktive arbeidsmappen — altså hvilken mappe Python leter i når vi oppgir relative filnavn.

```python
os.chdir('/ny/mappe')
```

## Hvorfor er dette viktig?

Når vi kjører et skript fra terminalen, er arbeidsmappen der vi kjørte kommandoen fra — ikke nødvendigvis der skriptet ligger.

```
/prosjekt/
    src/
        les_data.py
    data/
        personer.csv
```

Hvis vi starter `les_data.py` fra `/prosjekt/`, vil Python lete etter `personer.csv` i `/prosjekt/` og ikke finne den.

## Løsningen: bytt til skriptets egen mappe

```python
import os

# Finn mappen der skriptet ligger
skript_mappe = os.path.dirname(os.path.realpath(__file__))

# Bytt til den mappen
os.chdir(skript_mappe)
```

Nå kan vi bruke relative filnavn som `'../data/personer.csv'` og være sikre på at de fungerer uansett hvor vi starter skriptet fra.

### `__file__`

`__file__` er en innebygd Python-variabel som inneholder stien til det kjørende skriptet.

```python
print(__file__)  # f.eks. /prosjekt/src/les_data.py
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
filnavn = 'data.txt'

try:
    with open(filnavn, 'r', encoding='utf-8') as fil:
        innhold = fil.read()

except FileNotFoundError:
    print(f"Finner ikke filen: '{filnavn}'")

except PermissionError:
    print(f"Har ikke tilgang til å lese: '{filnavn}'")

except UnicodeDecodeError:
    print(f"Kan ikke lese '{filnavn}' som UTF-8")

except OSError as feil:
    print(f"Feil ved lesing av '{filnavn}': {feil}")
```

**Husk:** `OSError` er en generell feil som fanger opp mange typer filproblemer. Plasser den alltid sist i `except`-kjeden.

---

# Oppsummering

| Funksjon / Konsept | Beskrivelse |
|---|---|
| `open(fil, mode, encoding)` | Åpner en fil. Bruk alltid `encoding='utf-8'`. |
| `with open(...) as fil` | Åpner filen og lukker den automatisk etterpå. |
| `enumerate(fil, start=1)` | Gir linjenummer og innhold samtidig. |
| `os.path.exists(sti)` | Sjekker om stien finnes (fil eller mappe). |
| `os.path.isfile(sti)` | Sjekker om stien er en fil. |
| `os.path.isdir(sti)` | Sjekker om stien er en mappe. |
| `os.path.dirname(sti)` | Returnerer mappedelen av stien. |
| `os.path.basename(sti)` | Returnerer filnavnet fra stien. |
| `os.path.join(a, b)` | Slår sammen stier på tvers av operativsystem. |
| `os.path.realpath(__file__)` | Absolutt sti til det kjørende skriptet. |
| `os.chdir(mappe)` | Endrer arbeidsmappen. |

## Anbefalt arbeidsflyt for fillesing

1. Bytt til skriptets mappe med `os.chdir(os.path.dirname(os.path.realpath(__file__)))`.
2. Sjekk at filen finnes med `os.path.exists()`.
3. Sjekk at det er en fil med `os.path.isfile()`.
4. Åpne filen med `with open(..., encoding='utf-8')`.
5. Valider dataene linje for linje.
6. Håndter unntak med `except`-blokker.

**Husk:** Alltid sjekk at filen finnes og er av riktig type *før* du åpner den — da unngår du unødvendige unntak og gir brukeren tydelige feilmeldinger.
