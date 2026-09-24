# Oppgave: Analyser Aldersfordelingen

Du har fått et datasett med informasjon om flere personer. Datasettet inneholder følgende informasjon om hver person: fornavn, etternavn, alder, og kjønn.

### Datasett

```text
    Fornavn,Etternavn,Alder,Kjønn
    Ole,Johansen,44,Mann
    Marte,Knutsen,29,Kvinne
    Jonas,Pettersen,45,Mann
    Ingrid,Larsen,38,Kvinne
    Kjell,Andersen,51,Mann
    Sara,Hansen,27,Kvinne
    Eva,Olson,35,Kvinne
    Per,Nilsen,22,Mann
    Anna,Paulsen,40,Kvinne
    Øystein,Hågensen,24,Mann
```

### Oppgavebeskrivelse

1. **Beregn den totale alderen for alle menn i datasettet.**

2. **Beregn den totale alderen for alle kvinner i datasettet.**

3. **Hvor mange menn er det i datasettet?**

4. **Hvor mange kvinner er det i datasettet?**

### Validering av data

- **Dataene fra filen skal valideres**. Det betyr at programmet må sjekke at:
    1. Hver linje har nøyaktig fire felter: fornavn, etternavn, alder, og kjønn.
    2. Alderen er et gyldig tall (heltall).
    3. Kjønnet er enten "Mann" eller "Kvinne".
  
- Hvis dataene ikke oppfyller disse kravene, skal programmet gi en passende feilmelding og ignorere den ugyldige linjen. Programmet skal ikke krasje ved feil, men gi en tydelig tilbakemelding om hva som var galt.


   
### Krav

- Bruk programmering for å løse oppgaven, og strukturer programmet slik at det kan håndtere lignende datasett.
- Programmet skal lese inn dataene og utføre de nødvendige beregningene basert på kjønnsfordelingen.
- Skriv ut resultatene for hvert spørsmål i oppgaven.

### Eksempel på utskrift

```text
Total alder for alle menn er: 186 
Total alder for kvinner er: 169
Antall menn: 5
Antall kvinner: 5
```
