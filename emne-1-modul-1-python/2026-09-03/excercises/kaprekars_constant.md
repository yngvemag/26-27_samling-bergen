# Oppgave: Kaprekars konstant

Source: [Unveiling The Mystery: Understanding The Kaprekar’s Constant](https://infinitemathworld.com/unveiling-the-mystery-understanding-the-kaprekars-constant/)

I denne oppgaven skal du lage et program som utforsker **Kaprekars konstant**,
`6174`. Prosessen starter med et firesifret tall med minst to ulike sifre.
Sorter sifrene fra størst til minst og fra minst til størst, trekk det minste
tallet fra det største, og gjenta med resultatet. Du kommer til slutt til
`6174`.

Eksempel med starttallet `3524`:

```text
5432 - 2345 = 3087
8730 - 0378 = 8352
8532 - 2358 = 6174
```

Når du fortsetter fra `6174`, får du `7641 - 1467 = 6174`. Derfor kalles
`6174` en konstant i denne prosessen.

## Mål

Etter oppgaven skal du kunne:

- hente og validere tekst fra brukeren med `input()`;
- bruke strenger til å arbeide med sifrene i et tall;
- sortere data med `sorted()`;
- konvertere mellom `str` og `int`;
- bruke en `while`-løkke når programmet skal gjenta en prosess.

## Krav

Lag filen `kaprekar.py`. Programmet skal gjøre følgende:

1. Be brukeren skrive inn et firesifret tall.
2. Kontroller at inndata består av nøyaktig fire sifre.
3. Kontroller at tallet har minst to ulike sifre. Tall som `1111` og `0000`
   kan ikke brukes.
4. Fortsett å spørre om et gyldig tall til brukeren har skrevet inn én
   gyldig verdi.
5. Sorter sifrene i synkende rekkefølge og lag det største mulige tallet.
6. Sorter de samme sifrene i stigende rekkefølge og lag det minste mulige
   tallet.
7. Trekk det minste tallet fra det største, og skriv ut regnestykket.
8. Gjenta steg 5–7 til resultatet er `6174`.
9. Skriv ut hvor mange runder programmet brukte.

Behold ledende nuller når du viser det minste tallet. Hvis resultatet er
`3087`, skal programmet vise `0378` som det minste tallet i neste runde, selv
om Python regner det som tallet `378`.

## Eksempel på kjøring

```text
Skriv inn et firesifret tall: 3524

5432 - 2345 = 3087
8730 - 0378 = 8352
8532 - 2358 = 6174

Du nådde 6174 etter 3 runder.
```

Et eksempel på ugyldig inndata:

```text
Skriv inn et firesifret tall: 99
Du må skrive inn nøyaktig fire sifre.

Skriv inn et firesifret tall: 1111
Tallet må inneholde minst to ulike sifre.

Skriv inn et firesifret tall: 1000
1000 - 0001 = 999
9990 - 0999 = 8991
9981 - 1899 = 8082
8820 - 0288 = 8532
8532 - 2358 = 6174

Du nådde 6174 etter 5 runder.
```

## Tips

Start med å behandle brukerens inndata som en streng. Da kan du kontrollere
lengden med `len()` og sjekke om teksten bare inneholder sifre med
`isdigit()`.

```python
starttall = input("Skriv inn et firesifret tall: ")

if len(starttall) == 4 and starttall.isdigit():
    print("Gyldig format")
```

`sorted()` returnerer en liste med sorterte tegn. `join()` setter tegnene
sammen til én streng:

```python
sifre = "3524"
stigende = "".join(sorted(sifre))
synkende = "".join(sorted(sifre, reverse=True))

print(stigende)  # 2345
print(synkende)  # 5432
```

Du trenger `int()` når tallene skal trekkes fra hverandre. Bruk
f-strenger med `:04d` for å vise et tall med alltid fire sifre:

```python
minste_tall = 378
print(f"{minste_tall:04d}")  # 0378
```

## Forslag til fremgangsmåte

1. Lag først en løkke som ikke avsluttes før brukeren har skrevet inn et
   gyldig firesifret tall.
2. Test deretter sortering og subtraksjon med starttallet `3524`.
3. Legg subtraksjonen inn i en `while`-løkke som stopper når resultatet blir
   `6174`.
4. Tell antall runder med en variabel som starter på `0`.
5. Test programmet med flere starttall, også et tall med nuller.

## Test deg selv

Kontroller at programmet håndterer disse tilfellene:

| Inndata | Forventet resultat |
| --- | --- |
| `3524` | Når `6174` etter 3 runder. |
| `1000` | Viser ledende nuller og når `6174` etter 5 runder. |
| `1111` | Ber brukeren om å prøve igjen. |
| `12ab` | Ber brukeren om å prøve igjen. |
| `12345` | Ber brukeren om å prøve igjen. |

## Utvidelser

Velg én eller flere utvidelser når grunnoppgaven virker:

- La brukeren velge om programmet skal bruke tre eller fire sifre. For tre
  sifre er Kaprekars konstant `495`.
- La brukeren kjøre programmet flere ganger uten å starte filen på nytt.
- Lag en funksjon som utfører én Kaprekar-runde, og bruk funksjonen i
  løkken.
- Vis hele tallrekken på én linje etter at programmet er ferdig.
- Finn og skriv ut hvilket starttall av `1000` til `9999` som trenger flest
  runder før det når `6174`.

## Levering

Lever `kaprekar.py`. Programmet må kunne kjøres fra terminalen med:

```powershell
python kaprekar.py
```

Sjekk at programmet forklarer ugyldige inndata, viser alle rundene tydelig og
fungerer med starttallet `1000`.
