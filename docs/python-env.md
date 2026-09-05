# Python-miljøer og avhengigheter

Et Python-prosjekt trenger ofte eksterne pakker, for eksempel `requests` for
å hente data fra et API eller `pytest` for å teste programmet. Et
**virtuelt miljø** (environment) gir prosjektet sin egen, isolerte samling
med pakker. Da påvirker ikke pakkene i ett prosjekt de andre prosjektene på
maskinen.

Dette er viktig når prosjekter trenger ulike versjoner av samme pakke. Det
er også slik vi kan beskrive nøyaktig hva andre trenger for å kjøre koden
vår. Som backendutvikler skal du normalt opprette ett miljø per prosjekt.

> [!IMPORTANT]
> `.venv` og `.env` betyr ikke det samme:
>
> - `.venv` er mappen som inneholder et virtuelt Python-miljø.
> - `.env` er vanligvis en tekstfil med konfigurasjon, som API-adresser eller
>   hemmelige nøkler. Den er **ikke** stedet for installerte Python-pakker.
>
> Legg `requirements.txt` i prosjektmappen, på samme nivå som `.venv`, og
> ikke inne i `.venv` eller `.env`.

## Velg verktøy

Du trenger bare å bruke **én** av arbeidsflytene under i et prosjekt. Å
blande Conda med `venv` eller uv i samme prosjekt gjør det vanskelig å vite
hvilket miljø som faktisk brukes.

| Verktøy | Hva det gjør | Når det passer best |
| --- | --- | --- |
| `venv` og `pip` | Python sin innebygde løsning for miljøer og pakker. | Godt utgangspunkt for å lære grunnprinsippene. |
| Conda | Installerer både pakker og programmeringsspråk/biblioteker. | Vanlig innen dataanalyse, maskinlæring og pakker med systemavhengigheter. |
| uv | Rask prosjekt- og pakkehåndtering med låsefil. | Anbefalt i nye Python-prosjekter når du vil ha en moderne og reproduserbar arbeidsflyt. |

## Før du starter

Installer en terminal, en kodeeditor og det verktøyet du vil bruke. I VS Code
velger du deretter Python-miljøet fra prosjektet som interpreter. Bruk en ny
terminal etter installasjon hvis en kommando ikke blir funnet.

| Arbeidsflyt | Må installeres | Kontroller installasjonen |
| --- | --- | --- |
| `venv` og `pip` | [Python](https://www.python.org/downloads/) 3.13 eller nyere. `venv` og `pip` følger normalt med. Huk av **Add Python to PATH** i Windows-installasjonen. | `python --version` og `python -m pip --version` |
| Conda | [Miniconda](https://www.anaconda.com/docs/getting-started/miniconda/main) eller Anaconda. Miniconda er den mindre installasjonen og er nok for terminalbruk. | `conda --version` |
| uv | [uv](https://docs.astral.sh/uv/getting-started/installation/). I Windows kan du installere med `winget install --id=astral-sh.uv -e`. | `uv --version` |

På Windows er `py --version` et nyttig alternativ dersom `python` ikke
fungerer. Kommandoen `py -3.13` velger spesifikt Python 3.13 når flere
Python-versjoner er installert.

## Grunnbegreper

- **Pakke:** Gjenbrukbar kode som installeres fra
  [Python Package Index (PyPI)](https://pypi.org/), for eksempel `requests`.
- **Avhengighet:** En pakke prosjektet trenger for å virke.
- **Aktivere et miljø:** Gjøre miljøets Python og pakker til de aktive i den
  nåværende terminalen.
- **Reproduserbart miljø:** Andre kan installere de samme avhengighetene og
  få samme resultat.
- **Låsefil:** Fil som lagrer eksakte, testede pakkeversjoner. uv bruker
  `../uv.lock`; Conda kan bruke `environment.yml`.

## Arbeidsflyt 1: `venv` og `pip`

`venv` følger med Python og oppretter en isolert `.venv`-mappe. `pip`
installerer pakker i det aktive miljøet. Bruk helst `python -m pip` i stedet
for bare `pip`; da er det tydelig hvilken Python-installasjon som kjører pip.

### Opprett og bruk et miljø

Kjør kommandoene fra prosjektmappen.

```powershell
# Opprett miljøet bare én gang.
python -m venv .venv

# Aktiver miljøet i PowerShell.
.\.venv\Scripts\Activate.ps1

# Kontroller at Python kommer fra .venv.
python -c "import sys; print(sys.executable)"
python -m pip --version

# Installer en pakke i miljøet.
python -m pip install requests

# Kjør programmet med miljøets Python.
python app.py

# Forlat miljøet når du er ferdig.
deactivate
```

Når miljøet er aktivt, viser terminalen vanligvis `(.venv)` først på linjen.
I Windows Command Prompt bruker du `.\.venv\Scripts\activate.bat`. I macOS
og Linux bruker du `source .venv/bin/activate`.

Hvis PowerShell blokkerer aktiveringen, kan du tillate skript bare for den
åpne terminalen:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\.venv\Scripts\Activate.ps1
```

Denne innstillingen forsvinner når terminalen lukkes.

### Vanlige `pip`-kommandoer

| Kommando | Bruk |
| --- | --- |
| `python -m pip install requests` | Installer nyeste kompatible versjon av `requests`. |
| `python -m pip install "requests==2.32.3"` | Installer en bestemt versjon. |
| `python -m pip install --upgrade requests` | Oppgrader en installert pakke. |
| `python -m pip uninstall requests` | Fjern en pakke fra aktivt miljø. |
| `python -m pip list` | Vis pakker i aktivt miljø. |
| `python -m pip show requests` | Vis informasjon om én pakke. |
| `python -m pip freeze` | Vis installerbare pakker med eksakte versjoner. |
| `python -m pip check` | Kontroller at installerbare avhengigheter er kompatible. |

## `requirements.txt`: del avhengigheter med andre

`requirements.txt` er en vanlig tekstfil som forteller pip hvilke pakker som
skal installeres. Filen skal ligge i prosjektroten og versjonsstyres sammen
med koden. Den kopieres ikke inn i `.venv`.

For et lite prosjekt kan du skrive filen selv:

```text
requests==2.32.3
pytest==8.3.5
```

Installer deretter avhengighetene i et aktivert miljø:

```powershell
python -m pip install -r requirements.txt
```

Du kan også lage filen fra det aktive miljøet:

```powershell
python -m pip freeze > requirements.txt
```

Denne kommandoen tar med **alle** installerbare pakker, også indirekte
avhengigheter. Det er nyttig når du vil gjenskape et kjent miljø nøyaktig,
men gjennomgå filen før du lagrer den. Ikke kjør kommandoen med global Python
aktiv; da kan filen få med pakker som ikke hører til prosjektet.

Et vanlig oppsett er å skille program- og utviklingsavhengigheter:

```text
# requirements.txt
requests==2.32.3

# requirements-dev.txt
-r requirements.txt
pytest==8.3.5
```

Bruk da `python -m pip install -r requirements-dev.txt` når du skal utvikle
eller teste prosjektet.

## Arbeidsflyt 2: Conda

Conda er både en miljø- og pakkebehandler. I tillegg til Python-pakker kan
den installere avhengigheter som ofte er krevende å sette opp med pip, for
eksempel enkelte vitenskapelige biblioteker. Bruk Conda Prompt på Windows,
eller kjør `conda init powershell` én gang og åpne en ny PowerShell-terminal.

```powershell
# Opprett et miljø med valgt Python-versjon.
conda create --name backend python=3.13

# Aktiver miljøet.
conda activate backend

# Installer en pakke fra Conda-kanalen.
conda install requests

# Kjør kode og se installerte pakker.
python app.py
conda list

# Deaktiver eller fjern miljøet.
conda deactivate
conda env remove --name backend
```

Bruk `conda install` først for pakker Conda tilbyr. Hvis en nødvendig pakke
bare finnes på PyPI, kan du aktivere Conda-miljøet og deretter bruke
`python -m pip install pakkenavn`. Unngå å installere samme pakke både med
Conda og pip.

### Del et Conda-miljø

Conda bruker normalt `environment.yml`, ikke `requirements.txt`:

```powershell
# Eksporter miljøet.
conda env export --from-history > environment.yml

# Opprett miljøet på en annen maskin.
conda env create --file environment.yml
```

`--from-history` gir en kortere fil med pakkene du selv ba om. Du kan velge
navn når du oppretter miljøet med
`conda env create --file environment.yml --name backend`.

## Arbeidsflyt 3: uv

uv er en rask pakke- og prosjektbehandler. For nye prosjekter bruker uv
vanligvis `../pyproject.toml` for avhengigheter, `.venv` for miljøet og
`../uv.lock` for eksakte versjoner. Uv kan også laste ned en passende
Python-versjon når det er nødvendig.

### Start et nytt uv-prosjekt

```powershell
# Opprett en prosjektmappe med pyproject.toml.
uv init backend-eksempel
cd backend-eksempel

# Velg Python 3.13 og opprett/synkroniser .venv.
uv python pin 3.13
uv sync

# Legg til en produksjonsavhengighet.
uv add requests

# Legg til en avhengighet bare for utvikling og testing.
uv add --dev pytest

# Kjør uten å aktivere miljøet manuelt.
uv run python main.py
uv run pytest
```

`uv add` oppdaterer både `../pyproject.toml` og `../uv.lock`. Andre utviklere
trenger derfor vanligvis bare å klone prosjektet og kjøre `uv sync`.
Commit både `../pyproject.toml` og `../uv.lock`.

### Nyttige uv-kommandoer

| Kommando | Bruk |
| --- | --- |
| `uv init` | Opprett nytt prosjekt. |
| `uv sync` | Opprett eller oppdater `.venv` fra prosjektfilene. |
| `uv add pakkenavn` | Legg til en avhengighet. |
| `uv remove pakkenavn` | Fjern en avhengighet. |
| `uv run kommando` | Kjør en kommando i prosjektets miljø. |
| `uv tree` | Vis avhengighetstreet. |
| `uv python list` | Vis Python-versjoner uv kan bruke. |
| `uv venv` | Opprett bare et virtuelt miljø. |
| `uv pip install pakkenavn` | Bruk pip-kompatible kommandoer i et uv-miljø. |

### Bruk `requirements.txt` med uv

Uv støtter også eksisterende `requirements.txt`-filer. Dette er nyttig i
prosjekter som ikke har flyttet til `../pyproject.toml` ennå:

```powershell
# Opprett et miljø og installer fra requirements.txt.
uv venv
uv pip install -r requirements.txt

# Lag en requirements.txt fra uv-prosjektets låste avhengigheter.
uv export --format requirements-txt --output-file requirements.txt
```

For et nytt uv-prosjekt er `../pyproject.toml` og `../uv.lock` hovedkilden for
avhengigheter. Ikke vedlikehold både dem og en håndskrevet
`requirements.txt` uten en tydelig grunn; da kan versjonene komme ut av
synkronisering.

## Hva skal inn i Git?

Legg minst dette i `.gitignore`:

```gitignore
.venv/
.env
__pycache__/
```

Ikke legg `.venv` i Git. Mappen inneholder installerte filer som kan
gjenskapes fra `requirements.txt`, `../pyproject.toml` og `../uv.lock`, eller
`environment.yml`. Ikke legg `.env` i Git dersom den inneholder passord,
API-nøkler eller andre hemmeligheter. Del heller en `.env.example` med
ufarlige eksempelverdier.

## Feilsøking

| Problem | Løsning |
| --- | --- |
| `python` eller `pip` blir ikke funnet | Lukk og åpne terminalen. Kontroller Python-installasjonen med `py --version` på Windows. |
| Pakken importeres ikke | Aktiver riktig miljø og installer pakken med `python -m pip install pakkenavn`. |
| Feil Python brukes | Kjør `python -c "import sys; print(sys.executable)"` og velg `.venv` som interpreter i kodeeditoren. |
| `pip` installerer globalt | Aktiver `.venv` først, og bruk `python -m pip` fremfor en løs `pip`-kommando. |
| Ulike resultater på to maskiner | Installer på nytt fra `requirements.txt`, `../uv.lock` eller `environment.yml`, avhengig av arbeidsflyten. |
| Miljøet har blitt uoversiktlig | Deaktiver miljøet, slett bare prosjektets `.venv`-mappe, og opprett den på nytt fra avhengighetsfilen. |

## Miniøvelse

Lag en mappe som heter `pakke-øvelse`, og gjennomfør dette med `venv` og
`pip`:

1. Opprett og aktiver `.venv`.
2. Installer `requests`.
3. Lag `app.py` med koden under.
4. Kjør programmet.
5. Opprett `requirements.txt` og la en medstudent installere fra filen i et
   nytt miljø.

```python
import requests

respons = requests.get("https://api.github.com", timeout=10)
print(respons.status_code)
print(respons.headers["content-type"])
```

Forventet resultat er statuskoden `200` og en `content-type` som inneholder
`application/json`. Øvelsen viser at programmet er avhengig av `requests`,
og at avhengigheten kan beskrives slik at andre kan gjenskape miljøet.

## Oppsummering

Bruk et separat miljø i hvert Python-prosjekt. Velg én arbeidsflyt:
`venv` med `pip` for den innebygde standarden, Conda når prosjektet trenger
Conda-pakker, eller uv for en rask, moderne prosjektflyt med låsefil. Del
alltid en avhengighetsbeskrivelse, og aldri selve `.venv`-mappen.

## Videre lesing

- [Python-dokumentasjonen for `venv`](https://docs.python.org/3/library/venv.html)
- [pip user guide](https://pip.pypa.io/en/stable/user_guide/)
- [Conda: Getting started](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html)
- [uv documentation](https://docs.astral.sh/uv/)
