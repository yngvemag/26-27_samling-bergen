# Git: grunnkurs og kommandooppslag

Git er et versjonskontrollsystem. Det lagrer historikken til prosjektet, slik
at du kan se hva som er endret, samarbeide med andre og gå tilbake til en
tidligere versjon ved behov. GitHub er en nettjeneste der du kan lagre en kopi
av Git-prosjektet og samarbeide med andre.

En vanlig arbeidsflyt er:

1. Hent siste endringer med `git pull`.
2. Gjør én logisk endring i prosjektet.
3. Velg endringene med `git add`.
4. Lagre et beskrivende punkt i historikken med `git commit`.
5. Del endringen med `git push`.

> [!TIP]
> Kjør `git status` ofte. Kommandoen forteller hvilke filer som er endret,
> hvilke endringer som er klare for commit, og hvilken branch du arbeider på.

## Før du starter

Installer [Git for Windows](https://git-scm.com/downloads/win), og opprett en
[GitHub-konto](https://github.com/) dersom prosjektet skal deles på GitHub.
Åpne en ny PowerShell-terminal etter installasjonen, og kontroller Git:

```powershell
git --version
```

Sett navn og e-post én gang på din egen maskin. Git lagrer dette sammen med
commitene dine:

```powershell
git config --global user.name "Ditt navn"
git config --global user.email "din.epost@example.com"
```

Se innstillingene med `git config --global --list`. Bruk samme e-postadresse
som er lagt til GitHub-kontoen hvis commitene skal knyttes til profilen din.

## Start et lokalt repository og koble til GitHub

Et **lokalt repository** er Git-historikken på din maskin. Et **remote** er en
kobling til et repository på en tjener, ofte GitHub. `origin` er bare det
vanlige navnet på det primære remote-repositoryet.

Opprett først et tomt repository på GitHub, uten README, `.gitignore` eller
lisens. Kjør så følgende i prosjektmappen:

```powershell
# Start Git-historikk i denne mappen.
git init

# Gi hovedbranchen det vanlige navnet main.
git branch -M main

# Se aktuelle og usporbare filer.
git status

# Legg til filer, og lag første commit.
git add .
git commit -m "Initial commit"

# Koble prosjektet til repositoryet du opprettet på GitHub.
git remote add origin https://github.com/brukernavn/prosjektnavn.git

# Last opp hovedbranchen, og koble den til origin/main.
git push -u origin main
```

Bytt ut `brukernavn` og `prosjektnavn` med verdiene fra GitHub. Etter første
push holder det normalt å bruke `git push`.

Hvis GitHub-repositoryet allerede inneholder filer, for eksempel en README,
kloner du det i stedet for å kjøre `git init`:

```powershell
git clone https://github.com/brukernavn/prosjektnavn.git
cd prosjektnavn
```

## Lagre og dele endringer

Git har tre viktige områder:

- **Arbeidsmappen:** Filene slik de er på maskinen din akkurat nå.
- **Staging area:** Endringer du har valgt med `git add` til neste commit.
- **Repository:** Den lokale, lagrede Git-historikken med commitene dine.

Eksempel på en vanlig endring:

```powershell
# Undersøk hva som er endret.
git status
git diff

# Velg én fil, eller alle endrede og nye filer.
git add app.py
git add .

# Kontroller hva som er klart til commit.
git diff --staged

# Lag en kort commit-melding i imperativ form.
git commit -m "Add input validation"

# Del commitene med GitHub.
git push
```

En commit-melding forklarer hva endringen gjør, ikke hvordan du gjorde den.
Gode eksempler er `Add user input validation` og `Fix login error message`.

## Hent endringer fra GitHub

Kjør `git pull` før du begynner å arbeide og før du pusher. Kommandoen henter
endringer fra GitHub og fletter dem inn i branchen din.

```powershell
git pull
```

`git fetch` henter endringene uten å endre arbeidsmappen. Det er nyttig når du
først vil undersøke hva som finnes på GitHub:

```powershell
git fetch origin
git log --oneline main..origin/main
```

Hvis du har lokale endringer som ikke er committed, bør du committe eller
midlertidig legge dem bort før `git pull`:

```powershell
git stash
git pull
git stash pop
```

## Arbeid med branches

En **branch** er et separat spor i historikken. Du lager normalt en branch for
en avgrenset oppgave eller funksjon, mens `main` skal inneholde stabil kode.

```powershell
# Vis lokale branches. Stjernen viser den aktive branchen.
git branch

# Opprett og bytt til en ny branch.
git switch -c add-login

# Bytt til en eksisterende branch.
git switch main

# Last opp den nye branchen første gang.
git push -u origin add-login
```

`git switch` er den tydeligste kommandoen for å bytte branch. `git checkout`
er den eldre kommandoen du også møter ofte:

```powershell
git checkout -b add-login
git checkout main
```

Unngå å bytte branch når du har ucommittede endringer som Git ikke kan ta med
trygt. Kjør `git status`, commit endringene eller bruk `git stash` først.

## Merge og rebase

Når arbeidet på en feature-branch er klart, må det inn i `main`. Du kan gjøre
dette i GitHub med en pull request, eller lokalt med `merge`. En pull request
er vanligst når flere samarbeider, fordi noen kan gjennomgå endringen før den
flettes inn.

### Merge

`merge` lager vanligvis en ny commit som kobler historikken fra to branches.
Det er trygt og lett å forstå.

```powershell
# Stå på branchen som skal motta endringene.
git switch main
git pull

# Flett feature-branchen inn i main.
git merge add-login
git push
```

### Rebase

`rebase` flytter commitene fra din branch slik at de legges oppå den nyeste
historikken i en annen branch. Historikken blir rettere, men commit-ID-ene
endres.

```powershell
# Oppdater feature-branchen med siste main før du lager pull request.
git switch add-login
git fetch origin
git rebase origin/main
```

Ikke rebas en branch andre allerede arbeider på eller har basert arbeid på.
Hvis du har pushet din egen feature-branch før rebase, må du oppdatere GitHub
med en trygg force-push:

```powershell
git push --force-with-lease
```

Bruk aldri vanlig `git push --force` når `--force-with-lease` er tilgjengelig.
`--force-with-lease` stopper dersom remote-branchen er endret av andre etter
siste gang du hentet den.

## Løs en merge- eller rebase-konflikt

En konflikt oppstår når Git ikke kan velge mellom to endringer i samme del av
en fil. Git markerer konflikten i filen:

```text
<<<<<<< HEAD
din endring
=======
den andre endringen
>>>>>>> main
```

Gjør dette:

1. Åpne filen, velg eller kombiner riktig innhold, og fjern konfliktmarkørene.
2. Kontroller filen, og legg den til med `git add filnavn`.
3. Fullfør handlingen med riktig kommando.

```powershell
# Ved merge:
git commit

# Ved rebase:
git rebase --continue
```

Avbryt hvis du er usikker:

```powershell
git merge --abort
git rebase --abort
```

## Kommandooppslag

| Kommando | Hva den gjør |
| --- | --- |
| `git init` | Oppretter et nytt lokalt Git-repository i gjeldende mappe. |
| `git clone URL` | Laster ned et eksisterende repository med historikk. |
| `git status` | Viser branch og status for filendringer. |
| `git add filnavn` | Legger en bestemt fil i staging area. |
| `git add .` | Legger alle relevante endringer i gjeldende mappe i staging area. |
| `git commit -m "Melding"` | Lagrer staged endringer i lokal historikk. |
| `git log --oneline` | Viser korte commit-meldinger og commit-ID-er. |
| `git diff` | Viser endringer som ennå ikke er staged. |
| `git diff --staged` | Viser endringer som blir med i neste commit. |
| `git pull` | Henter og integrerer siste endringer fra remote. |
| `git push` | Laster lokale commits opp til den tilkoblede branchen. |
| `git remote -v` | Viser URL-ene til tilkoblede remotes. |
| `git remote add origin URL` | Kobler et lokalt repository til GitHub. |
| `git branch` | Viser eller oppretter lokale branches. |
| `git switch navn` | Bytter til en eksisterende branch. |
| `git switch -c navn` | Oppretter og bytter til en ny branch. |
| `git checkout navn` | Eldre kommando for å bytte branch. |
| `git merge navn` | Fletter den angitte branchen inn i aktiv branch. |
| `git rebase branch` | Legger aktive branch sine commits oppå en annen branch. |
| `git stash` | Legger ucommittede endringer midlertidig bort. |
| `git restore filnavn` | Forkaster ucommittede endringer i én fil. |

> [!WARNING]
> `git restore filnavn` forkaster ucommittede endringer i filen. Kontroller
> alltid `git diff` før du bruker kommandoen.

## Oppsummering

Bruk `git status` for å holde oversikt. Arbeid i en egen branch, hent siste
endringer før du begynner, og lag små commits med tydelige meldinger. Koble
det lokale repositoryet til GitHub med `git remote add origin URL`, og del
arbeidet med `git push`. Bruk vanligvis merge eller pull request for å samle
branches; bruk rebase bevisst og bare på branches du selv kontrollerer.

## Videre lesing

- [Git-dokumentasjonen](https://git-scm.com/doc)
- [GitHub Docs: opprette et repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository)
- [GitHub Docs: samarbeide med pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests)
