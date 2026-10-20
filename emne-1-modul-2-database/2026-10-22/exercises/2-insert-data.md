
# Oppgave 2 – Legg inn eksempeldata

Når databasen og tabellene er opprettet, skal databasen fylles med eksempeldata.

## Studenter

Legg inn følgende studenter:

| Fornavn | Etternavn | Studie | Startår |
|---|---|---|---:|
| Emma | Hansen | Backend-programmering | 2026 |
| Oliver | Johansen | Backend-programmering | 2026 |
| Nora | Larsen | Backend-programmering | 2026 |
| Jakob | Nilsen | Backend-programmering | 2026 |
| Sofie | Berg | Backend-programmering | 2026 |
| Magnus | Eriksen | Backend-programmering | 2025 |
| Ida | Andersen | Backend-programmering | 2025 |
| Henrik | Olsen | Backend-programmering | 2025 |
| Thea | Pedersen | Backend-programmering | 2025 |
| Lucas | Kristiansen | Frontend-utvikling | 2026 |
| Sara | Moen | Frontend-utvikling | 2026 |
| Emil | Solberg | Frontend-utvikling | 2026 |
| Ingrid | Dahl | Frontend-utvikling | 2025 |
| Mathias | Lunde | Frontend-utvikling | 2025 |
| Amalie | Strand | Frontend-utvikling | 2025 |
| William | Lie | Cybersikkerhet | 2026 |
| Maja | Knutsen | Cybersikkerhet | 2026 |
| Noah | Eide | Cybersikkerhet | 2026 |
| Ella | Haugen | Cybersikkerhet | 2025 |
| Aksel | Bakke | Cybersikkerhet | 2025 |

Lag en unik e-postadresse for hver student på formen:

```text
fornavn.etternavn@example.com
```

## Emner

Legg inn følgende emner:

| Emne | Studiepoeng |
|---|---:|
| Databaser | 10 |
| Objektorientert programmering | 10 |
| Backend-utvikling | 15 |
| Frontend-utvikling | 15 |
| Cybersikkerhet | 10 |
| Cloud og containere | 10 |

### Karakterer

Legg deretter inn karakterer for studentene.

Bruk karakterskalaen:

```text
A, B, C, D, E, F
```

Datasettet skal inneholde ulike karakterer slik at vi senere kan undersøke og sammenligne resultatene.

Noen emner kan være felles for flere studier, mens andre kan være knyttet til bestemte studier.

Eksempel:

- Studenter på Backend-programmering kan ha karakter i `Backend-utvikling`.
- Studenter på Frontend-utvikling kan ha karakter i `Frontend-utvikling`.
- Studenter på Cybersikkerhet kan ha karakter i `Cybersikkerhet`.
- `Databaser` kan inneholde studenter fra alle tre studiene.
- `Cloud og containere` kan inneholde studenter fra flere stud