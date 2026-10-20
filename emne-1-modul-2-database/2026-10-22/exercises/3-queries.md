# Oppgave 3 – SELECT og utforsking av data

I denne delen skal du bruke SQL til å undersøke databasen. Du skal arbeide med filtrering, sortering, aggregering og kobling av data fra flere tabeller.

1. **Studentoversikt:** Vis fornavn, etternavn, studie og startår for alle studenter. Sorter alfabetisk etter etternavn.

2. **Backend-studenter:** Finn alle studenter som går på `Backend-programmering`. Vis fornavn, etternavn og startår.

3. **Studenter fra 2026:** Finn alle studenter som startet i 2026. Sorter først etter studie og deretter etter etternavn.

4. **Utvalgte studier:** Finn studenter som går på `Frontend-utvikling` eller `Cybersikkerhet`. Vis navn og studie.

5. **Antall studenter per studie:** Finn ut hvor mange studenter som går på hvert studie. Vis studie og antall studenter. Sorter studiet med flest studenter først.

6. **Karakterfordeling:** Finn ut hvor mange ganger hver karakter forekommer. Vis karakter og antall. Sorter fra A til F.

7. **Studier med mange studenter:** Finn studier som har mer enn 5 studenter. Vis studie og antall studenter.

8. **Student og karakter:** Lag en oversikt som kombinerer `students` og `grades`. Vis studentens fornavn, etternavn og karakter.

9. **Full karakteroversikt:** Lag en oversikt som henter informasjon fra alle tre tabellene. Vis studentens fornavn, etternavn, studie, emnenavn og karakter. Sorter først etter etternavn og deretter etter emnenavn.

10. **Karakterer i Databaser:** Finn alle studenter som har fått karakter i emnet `Databaser`. Vis studentens navn, studie og karakter. Sorter etter karakter.

11. **A-karakterer:** Finn alle studenter som har fått `A`. Vis studentens navn, studie, emnenavn og karakter.

12. **Ikke bestått:** Finn alle studenter som har fått `F`. Vis studentens navn, emnenavn og karakter.

13. **Antall karakterer per emne:** Finn ut hvor mange karakterer som er registrert i hvert emne. Vis emnenavn og antall karakterer. Sorter emnet med flest registrerte karakterer først.

14. **Karakterfordeling i Databaser:** Finn ut hvor mange `A`, `B`, `C`, `D`, `E` og `F` som er registrert i emnet `Databaser`.

15. **Antall A per emne:** Finn ut hvor mange `A`-karakterer som er registrert i hvert emne. Vis emnenavn og antall. Sorter emnet med flest A først.

16. **Karakterfordeling per studie:** Finn ut hvor mange ganger hver karakter forekommer på hvert studie. Vis studie, karakter og antall.

17. **Utforskingsoppgave:** Finn emnet som har flest `A`-karakterer. Du får ikke oppgitt hvilke SQL-elementer som skal brukes. Forklar kort hvordan du kom frem til løsningen.


# Oppgave 4 – INSERT, UPDATE og DELETE

I denne delen skal du arbeide videre med dataene ved å legge til, endre og slette informasjon.

> **Viktig:** Før du bruker `UPDATE` eller `DELETE`, skal du først bruke `SELECT` med tilsvarende betingelse for å kontrollere hvilke rader som vil bli påvirket.

1. **Registrer en ny student:** Registrer Maria Holm med e-post `maria.holm@example.com`, studie `Backend-programmering` og startår 2026. Kontroller at studenten ble registrert. I kontrollspørringen skal du ikke bruke `student_id`.

2. **Registrer et nytt emne:** Registrer emnet `Web API` med 10 studiepoeng. Kontroller at emnet ble registrert uten å være avhengig av hvilken `subject_id` emnet fikk.

3. **Registrer en karakter:** Maria Holm har fått karakter `B` i `Web API`. Du får ikke oppgitt `student_id` eller `subject_id`. Finn først de nødvendige verdiene i databasen og registrer karakteren. Kontroller resultatet med en spørring som viser studentens navn, emnenavn og karakter.

4. **Endre startår:** Maria Holm ble registrert med feil startår. Endre startåret fra 2026 til 2025. Finn først raden som blir påvirket, utfør oppdateringen og kontroller resultatet.

5. **Endre studiepoeng:** Emnet `Cloud og containere` skal endres fra 10 til 15 studiepoeng. Kontroller verdien før og etter oppdateringen.

6. **Endre flere studenter:** Alle studenter på `Frontend-utvikling` som startet i 2025, skal få studienavnet endret til `Frontend- og webutvikling`. Finn først studentene som blir påvirket, utfør oppdateringen og kontroller resultatet.

7. **Opprett og slett testdata:** Opprett en teststudent og kontroller at studenten finnes. Slett deretter studenten og kontroller at studenten ikke lenger finnes.

8. **Test fremmednøkkel:** Opprett en ny teststudent og registrer en karakter på studenten. Forsøk deretter å slette studenten fra `students`. Forklar hva som skjer og hvorfor databasen stopper slettingen.

9. **Slett relaterte data:** Slett testdataene fra forrige oppgave. Du må selv finne riktig rekkefølge for å slette karakteren og studenten. Forklar hvorfor rekkefølgen er viktig.