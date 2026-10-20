# Oppsett av Python og MySQL

Denne veiledningen setter opp Python-eksemplene for økten 22. oktober 2026.
Eksemplene kobler Python til MySQL-databasen `school` og leser innloggings-
informasjon fra en lokal `.env`-fil.

## Du trenger

- MySQL Server som kjører på maskinen din
- En MySQL-bruker med tilgang til databasen `school`
- Databasen og tabellene fra
  [øvelse 1](../2026-10-22/excercises/1-setup-db.md)

## Installer bibliotekene

1. Åpne en terminal i mappen
   `emne-1-modul-2-database\2026-10-22\src\python`.
2. Opprett og aktiver et virtuelt miljø:

   ```powershell
   py -3.13 -m venv .venv
   .\.venv\Scripts\Activate.ps1
   ```

3. Installer avhengighetene:

   ```powershell
   python -m pip install -r requirements.txt
   ```

`mysql-connector-python` lar Python koble til MySQL. `python-dotenv` leser
variabler fra `.env`-filen, slik at passordet ikke skrives direkte i Python-
koden.

> Hvis PowerShell ikke lar deg aktivere miljøet, kjør kommandoen nedenfor i
> samme terminal og prøv igjen:
>
> ```powershell
> Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
> ```

## Opprett `.env`-filen

1. Opprett filen `.env` i mappen `src\python`.
2. Legg inn dine egne databaseverdier:

   ```dotenv
   USER_NAME=root
   PASSWORD=gokstad
   DATABASE=school
   ```

Eksempelet bruker `localhost` og standard MySQL-port `3306`. Variablene må
hete nøyaktig `USER_NAME`, `PASSWORD` og `DATABASE`, fordi `main.py` leser
disse navnene.

Ikke del eller last opp `.env`-filen. Den kan inneholde passord. Del heller
oppsettet uten passord når andre skal bruke prosjektet.

## Test tilkoblingen

1. Start MySQL Server.
2. Kontroller at databasen `school` finnes og inneholder tabellen `students`.
3. Kjør programmet fra mappen `src\python`:

   ```powershell
   python main.py
   ```

Programmet skriver ut studentene sortert etter etternavn når tilkoblingen
fungerer.

## Feilsøking

| Problem | Løsning |
| --- | --- |
| `ModuleNotFoundError` | Aktiver `.venv` og kjør `python -m pip install -r requirements.txt` på nytt. |
| `Access denied for user` | Kontroller `USER_NAME` og `PASSWORD` i `.env`. |
| `Unknown database 'school'` | Opprett databasen ved å følge [øvelse 1](../2026-10-22/excercises/1-setup-db.md). |
| Kan ikke koble til MySQL | Kontroller at MySQL Server kjører, og at den bruker `localhost` og port `3306`. |
