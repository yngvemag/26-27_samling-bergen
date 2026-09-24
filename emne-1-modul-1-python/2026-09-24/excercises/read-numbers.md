# Oppgave: Lesing av tall fra fil og feilhåndtering

En fil inneholder flere linjer hvor hvert element er adskilt med komma. Elementene kan være enten heltall eller flyttall.

Du skal lage et program som:

1. Leser inn filen linje for linje.
2. Deler opp hver linje i individuelle tall.
3. Konverterer elementene til tall (heltall eller flyttall).
4. Beregner summen av tallene på hver linje.
5. Skriver ut regnestykket og summen for hver linje med to desimaler.

**Feilhåndtering:** Programmet skal håndtere eventuelle ugyldige data i filen uten å krasje.

## Eksempel på fil

```text
2, 4, 756, 23.4, 7,3
1, 3, 4, 3
56, 7, 8, 9, 4, 23, 543.34, 453.23, 34,53
4.42, 38, 3
```

## Forventet utskrift

```text
2 + 4 + 756 + 23.4 + 7 + 3 = 795.40
1 + 3 + 4 + 3 = 11.00
56 + 7 + 8 + 9 + 4 + 23 + 543.34 + 453.23 + 34 + 53 = 1190.57
4.42 + 38 + 3 = 45.42
```

## Krav til løsningen

- Bruk filbehandling for å lese inn dataene.
- Bruk `split()` for å dele opp linjene.
- Bruk løkker for å behandle tallene.
- Bruk `try` og `except` for å håndtere feil.
- Formater summen med to desimaler.