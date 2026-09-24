# Oppgavesamling: Innebygde funksjoner i Python

## Innhold

- [Nivå 1 – Grunnleggende](#nivå-1--grunnleggende)
- [Nivå 2 – Lister og databehandling](#nivå-2--lister-og-databehandling)
- [Nivå 3 – Videregående](#nivå-3--videregående)
- [Nivå 4 – OOP og refleksjon](#nivå-4--oop-og-refleksjon)

**Generelle krav:** Lag en egen funksjon for hver oppgave. Bruk den angitte innebygde funksjonen. Test med minst to ulike datasett, inkludert relevante grensetilfeller. Når en oppgave ber om en liste fra `map()`, `filter()`, `zip()` eller `reversed()`, konverter resultatet med `list()` ved behov.

## Nivå 1 – Grunnleggende

### `sum()` – Summerer tall
1. Lag en funksjon som returnerer summen av alle tallene i en liste.
2. Skriv en funksjon som beregner gjennomsnittet av tallene i en liste. Håndter tomme lister.
3. Lag en funksjon som beregner summen av alle partall i en liste.
4. Lag en funksjon som tar en liste med handlekurvpriser og returnerer totalprisen etter en oppgitt prosentvis rabatt.

### `min()` og `max()` – Finner minste og største verdi
1. Lag en funksjon som finner det største tallet i en liste.
2. Lag en funksjon som returnerer både laveste og høyeste temperatur fra en liste.
3. Skriv en funksjon som finner den yngste personen i en liste med tupler på formen `(navn, alder)`.
4. Lag en funksjon som finner den lengste strengen i en liste med ord.

### `len()` – Teller elementer
1. Lag en funksjon som returnerer antall tegn i en streng.
2. Skriv en funksjon som teller hvor mange elementer det finnes i en liste.
3. Lag en funksjon som finner det lengste ordet i en setning.
4. Lag en funksjon som tar en liste med setninger og returnerer antall ord i hver setning.

### `abs()` – Finner absoluttverdi
1. Lag en funksjon som returnerer absoluttverdien av et tall.
2. Skriv en funksjon som beregner avstanden mellom to tall på tallinjen.
3. Lag en funksjon som returnerer absoluttverdien av hvert tall i en liste.
4. Lag en funksjon som finner tallet som ligger nærmest null i en liste.

### `round()` – Avrunder tall
1. Lag en funksjon som avrunder et flyttall til to desimaler.
2. Skriv en funksjon som returnerer priser avrundet til nærmeste hele krone. Undersøk hvordan Python håndterer verdier som ender på `.5`.
3. Lag en funksjon som beregner gjennomsnittet av tall og avrunder resultatet til én desimal.
4. Lag en funksjon som konverterer Celsius til Fahrenheit og avrunder resultatene til to desimaler.

### `range()` – Lager en tallsekvens
1. Lag en funksjon som returnerer tallene fra 1 til 100 som en liste.
2. Skriv en funksjon som returnerer alle partall mellom to oppgitte heltall, inkludert grensene.
3. Lag en funksjon som genererer gangetabellen for et oppgitt tall fra 1 til 10.
4. Skriv en funksjon som tar starttall, sluttall og steglengde og returnerer tallene i intervallet. Definer om sluttallet skal være inkludert.

## Nivå 2 – Lister og databehandling

### `zip()` – Kombinerer elementer fra flere itererbare objekter
1. Lag en funksjon som tar to lister og bruker `zip()` til å returnere en liste med tupler der hvert element er et par fra listene.
2. Skriv en funksjon som tar to lister, én med navn og én med karakterer. Bruk `zip()` til å lage en ordbok som matcher navnene med karakterene. Forutsett at navnene er unike.
3. Lag en funksjon som kombinerer tre lister (fornavn, etternavn og alder) til en liste med tupler der hvert tuppel inneholder disse tre verdiene for én person.
4. Skriv en funksjon som tar to lister med tall av ulik lengde og returnerer summen av tilsvarende elementer ved hjelp av `zip()`. Elementer uten partner skal ignoreres.
5. Lag en funksjon som tar en liste med koordinater og en liste med farger. Bruk `zip()` til å returnere en liste med fargekodede koordinater som tupler.

### `reversed()` – Snur rekkefølgen
1. Lag en funksjon som tar en streng og returnerer strengen i omvendt rekkefølge ved hjelp av `reversed()`.
2. Skriv en funksjon som tar en liste med tall og returnerer en liste med tallene i omvendt rekkefølge ved hjelp av `reversed()`.
3. Lag en funksjon som tar en setning og returnerer en ny setning der ordene kommer i omvendt rekkefølge.
4. Skriv en funksjon som tar en liste med navn, sorterer den alfabetisk med `sorted()` og bruker `reversed()` til å returnere omvendt alfabetisk rekkefølge. Sammenlign med `sorted(..., reverse=True)`.
5. Lag en funksjon som tar en matrise representert som en liste med lister og returnerer en ny matrise der hver rad er reversert ved hjelp av `reversed()`.

### `sorted()` – Returnerer sorterte verdier
1. Lag en funksjon som tar en liste med tall og returnerer tallene sortert i stigende rekkefølge ved hjelp av `sorted()`.
2. Skriv en funksjon som tar en liste med tupler på formen `(navn, alder)` og sorterer etter alder ved hjelp av `sorted()`.
3. Lag en funksjon som tar en liste med ord og sorterer dem etter lengde ved hjelp av `sorted()`.
4. Skriv en funksjon som tar en liste med setninger og sorterer dem etter antall ord.
5. Lag en funksjon som tar en matrise representert som en liste med lister og sorterer radene etter summen av tallene i hver rad ved hjelp av `sorted()`.

### `filter()` – Velger elementer som oppfyller et kriterium
1. Lag en funksjon som tar en liste med tall og returnerer bare partallene ved hjelp av `filter()`.
2. Skriv en funksjon som tar en liste med strenger og beholder bare strengene som er lengre enn fem tegn ved hjelp av `filter()`.
3. Lag en funksjon som tar en liste med tall og returnerer bare de positive tallene ved hjelp av `filter()`.
4. Skriv en funksjon som tar en liste med ord og returnerer bare ordene som starter med en vokal. Håndter både store og små bokstaver.
5. Lag en funksjon som tar en liste med personer representert som tupler `(navn, alder)` og returnerer personer som er eldre enn 18 år ved hjelp av `filter()`.

### `map()` – Bruker en funksjon på hvert element
1. Lag en funksjon som tar en liste med tall og returnerer en ny liste der hvert tall er multiplisert med 2 ved hjelp av `map()`.
2. Skriv en funksjon som tar en liste med strenger og returnerer strengene konvertert til store bokstaver ved hjelp av `map()`.
3. Lag en funksjon som tar en liste med temperaturer i Celsius og returnerer temperaturene i Fahrenheit ved hjelp av `map()`.
4. Skriv en funksjon som tar to lister med tall og returnerer summen av tilsvarende elementer ved hjelp av `map()`. Elementer uten partner skal ignoreres.
5. Lag en funksjon som tar en liste med ord og returnerer lengden av hvert ord ved hjelp av `map()`.

### `enumerate()` – Gir indeks og verdi
1. Lag en funksjon som tar en liste med navn og skriver dem ut nummerert fra 1.
2. Lag en funksjon som tar en liste med karakterer og returnerer tupler med indeks og karakter.
3. Skriv en funksjon som finner indeksen til det første negative tallet i en liste. Returner `-1` hvis ingen finnes.
4. Lag en funksjon som tar en liste med produkter og returnerer en ordbok med produktnummer fra 1 som nøkler og produktnavn som verdier.

## Nivå 3 – Videregående

### `any()` – Sjekker om minst ett element er sant
1. Lag en funksjon som sjekker om en liste inneholder minst ett negativt tall.
2. Skriv en funksjon som undersøker om minst én student har fått karakteren A.
3. Lag en funksjon som sjekker om minst ett brukernavn i en liste er tomt.
4. Lag en funksjon som undersøker om minst én temperatur overstiger 30 grader.

### `all()` – Sjekker om alle elementer er sanne
1. Lag en funksjon som sjekker om alle tall i en liste er positive.
2. Skriv en funksjon som kontrollerer om alle studenter har bestått en prøve (minst 50 poeng).
3. Lag en funksjon som sjekker om alle strenger i en liste inneholder minst fem tegn.
4. Skriv en funksjon som kontrollerer om alle produkter i en handlekurv har pris over null.

### `isinstance()` – Kontrollerer type eller klasse
1. Lag en funksjon som sjekker om en verdi er et heltall. Avklar om `bool` skal regnes med.
2. Skriv en funksjon som tar en liste med forskjellige datatyper og returnerer bare strengene.
3. Lag en funksjon som teller hvor mange elementer som er av typen `int`, men ikke `bool`.
4. Lag en funksjon som sjekker om et objekt er en instans av `Student` eller en underklasse av `Student`.

### `dict()` – Oppretter en ordbok
1. Lag en funksjon som tar tupler `(navn, alder)` og oppretter en ordbok. Forutsett unike navn.
2. Skriv en funksjon som bruker `dict()` og `zip()` til å kombinere produktnavn og priser.
3. Lag en funksjon som oppretter en ordbok fra en liste med nøkkel-verdi-par.
4. Skriv en funksjon som kobler studentnummer til navn ved hjelp av to lister.

### `set()` – Lager en mengde med unike verdier
1. Lag en funksjon som fjerner duplikater fra en liste med tall. Rekkefølgen trenger ikke bevares.
2. Skriv en funksjon som finner unike ord i en setning uten å skille mellom store og små bokstaver.
3. Lag en funksjon som finner elementene som finnes i begge av to lister.
4. Skriv en funksjon som returnerer alle unike verdier fra to lister, sortert i stigende rekkefølge.

## Nivå 4 – OOP og refleksjon

### `type()` – Returnerer objektets type
1. Lag en funksjon som tar et objekt og returnerer navnet på datatypen.
2. Opprett klassene `Person`, `Student` og `Teacher`. Skriv ut den konkrete klassen til hvert objekt ved hjelp av `type()`.
3. Lag en funksjon som teller hvor mange verdier det finnes av hver datatype i en liste.
4. Undersøk forskjellen mellom `type()` og `isinstance()` med en overklasse og en underklasse.

### `getattr()` – Henter et attributt ved navn
1. Lag en klasse `Student` med `navn` og `alder`. Bruk `getattr()` til å hente `navn`.
2. Skriv en funksjon som tar et objekt og et attributtnavn og returnerer verdien, eller teksten «Ukjent» hvis attributtet mangler.
3. Lag en funksjon som tar en liste med `Student`-objekter og et attributtnavn og returnerer attributtverdien fra hver student.
4. Lag en funksjon som henter og kaller en metode ved navn dersom attributtet finnes og er kallbart.

### `hasattr()` – Undersøker om et attributt finnes
1. Lag en funksjon som sjekker om et `Student`-objekt har attributtet `student_id`.
2. Opprett klassene `Hund` og `Katt`, der bare `Hund` har metoden `hent()`. Sjekk hvilke objekter som har metoden.
3. Lag en funksjon som returnerer alle objekter i en liste som har attributtet `navn`.
4. Skriv en funksjon som sjekker om et objekt har metoden `vis_info()`, og utfører den dersom attributtet finnes og er kallbart.

### Refleksjonsoppgaver
1. Løs én oppgave med `map()` og deretter med en list comprehension. Sammenlign lesbarheten.
2. Løs én oppgave med `filter()` og deretter med en list comprehension. Forklar forskjellene.
3. Undersøk hva `zip()` gjør når listene har ulik lengde, og hvordan `zip(..., strict=True)` oppfører seg i Python 3.10 eller nyere.
4. Undersøk hva `any([])` og `all([])` returnerer, og forklar resultatet.
5. Forklar hvorfor `reversed()` ikke er det samme som sortering.
6. Undersøk hvorfor `isinstance(True, int)` er `True`, og hvordan du kan skille boolske verdier fra heltall.

## Viktige presiseringer

- `reversed()` snur eksisterende rekkefølge; bruk `sorted()` for å sortere.
- `zip()` og `map()` med flere itererbare objekter stopper som standard ved den korteste.
- `map()`, `filter()`, `zip()` og `reversed()` gir iteratorer, ikke ferdige lister.
- `all([])` returnerer `True`, mens `any([])` returnerer `False`.
- `round()` bruker avrunding til nærmeste partall ved eksakte halvveisverdier; binær flyttallsrepresentasjon kan påvirke enkelte resultater.
- `set()` garanterer ikke at den opprinnelige rekkefølgen beholdes.
