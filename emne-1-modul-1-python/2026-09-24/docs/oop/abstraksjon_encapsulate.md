# Abstraksjon i Python

Abstraksjon er et av de grunnleggende prinsippene i objektorientert programmering (OOP).

**Abstraksjon betyr at vi fokuserer på hva et objekt kan gjøre, uten at vi trenger å kjenne til alle detaljene om hvordan det fungerer.**

Tenk på en bil:

- Vi bruker rattet for å styre.
- Vi bruker gasspedalen for å akselerere.
- Vi trenger ikke å vite nøyaktig hvordan motoren og styringssystemet fungerer.

På samme måte kan vi lage klasser som tilbyr enkle metoder, mens den interne implementasjonen skjules.

---

# 1. Abstrakte klasser (Abstract Base Classes)

I Python kan vi bruke modulen `abc` for å lage abstrakte klasser.

En abstrakt klasse fungerer som en felles mal for andre klasser.

Den kan definere metoder som underklassene må implementere før de kan opprettes som objekter.

Vi bruker:

- `ABC` for å definere en abstrakt klasse.
- `@abstractmethod` for å definere en abstrakt metode.

## Eksempel: Kjøretøy

Vi ønsker at alle kjøretøy skal ha en metode som heter `drive()`.

Vi vet imidlertid ikke hvordan hvert kjøretøy skal implementere denne metoden.

```python id="f0kq5b"
from abc import ABC, abstractmethod

class Vehicle(ABC):

    @abstractmethod
    def drive(self):
        pass
```

Klassen `Vehicle` definerer at alle konkrete underklasser må implementere metoden `drive()`.

Vi kan ikke opprette et objekt direkte fra denne klassen:

```python id="c42ymv"
# Raises TypeError
# vehicle = Vehicle()
```

Dette skyldes at klassen inneholder en abstrakt metode som ikke har en konkret implementasjon.

---

## 2. Implementere abstrakte metoder

Vi kan nå opprette underklasser som arver fra `Vehicle`.

Hver underklasse må implementere metoden `drive()` for å kunne opprettes som et objekt.

```python id="wb7efp"
class Car(Vehicle):

    def drive(self):
        return "The car is driving on the road"


class Boat(Vehicle):

    def drive(self):
        return "The boat is sailing on the water"
```

Vi kan opprette objekter og bruke metodene:

```python id="2v1up4"
car = Car()
boat = Boat()

print(car.drive())
print(boat.drive())
```

**Utskrift:**

```text id="zk16wm"
The car is driving on the road
The boat is sailing on the water
```

### Hva skjer?

1. `Vehicle` definerer at alle kjøretøy skal ha metoden `drive()`.
2. `Car` implementerer sin egen versjon av metoden.
3. `Boat` implementerer sin egen versjon av metoden.

Vi har dermed definert et felles grensesnitt uten å bestemme hvordan hver underklasse skal utføre handlingen.

Dette er abstraksjon.

---

# 3. Abstraksjon og polymorfisme

Abstraksjon og polymorfisme brukes ofte sammen.

Når flere klasser implementerer det samme grensesnittet, kan vi behandle objektene på en felles måte.

Vi fortsetter med klassene fra forrige eksempel.

```python id="6d2jvh"
vehicles = [
    Car(),
    Boat()
]

for v in vehicles:
    print(v.drive())
```

**Utskrift:**

```text id="qgrc8o"
The car is driving on the road
The boat is sailing on the water
```

Vi trenger ikke å vite om objektet er en bil eller en båt.

Vi trenger bare å vite at objektet har metoden `drive()`.

**Forskjellen:**

- Abstraksjon definerer hvilke operasjoner som skal være tilgjengelige.
- Polymorfisme gjør at forskjellige objekter kan implementere og utføre disse operasjonene på ulike måter.

---

# 4. Innkapsling (Encapsulation)

Innkapsling er et annet viktig prinsipp i OOP.

**Innkapsling betyr at vi samler data og metoder i en klasse og kontrollerer hvordan objektets interne tilstand kan endres.**

Vi ønsker for eksempel ikke at brukeren skal kunne endre saldoen på en bankkonto helt fritt.

I stedet kan vi tilby metoder som:

- `deposit()` – setter inn penger.
- `withdraw()` – tar ut penger.
- `get_balance()` – viser saldoen.

Disse metodene bestemmer hvordan saldoen kan endres.

---

## 5. Offentlige og interne attributter i Python

Python bruker navnekonvensjoner for å signalisere hvordan attributter er ment å brukes.

| Syntaks | Betydning |
|---|---|
| `self.balance` | Offentlig attributt. |
| `self._balance` | Internt attributt som normalt ikke bør brukes direkte utenfor klassen. |
| `self.__balance` | Attributt med name mangling, som gjør utilsiktet tilgang og navnekollisjoner vanskeligere. |

### Eksempel

```python id="u0pg1c"
class BankAccount:

    def __init__(self, balance):
        self.__balance = balance
```

Her bruker vi `__balance` for å signalisere at saldoen er en intern del av klassen.

Forsøk på direkte tilgang vil normalt gi en feil:

```python id="i2o8h3"
account = BankAccount(1000)

# Raises AttributeError
# print(account.__balance)
```

**Viktig:** Python har ikke strengt private attributter på samme måte som enkelte andre språk.

Dobbel understrek aktiverer *name mangling*, som endrer attributtnavnet internt. Det gjør ikke attributtet fullstendig utilgjengelig.

---

# 6. Komplett eksempel: BankAccount

Vi skal lage en bankkonto der saldoen bare kan endres gjennom bestemte metoder.

```python id="h8q2pw"
class BankAccount:

    def __init__(self, owner, balance=0):
        self.owner = owner
        self.__balance = balance

    def deposit(self, amount):
        if amount <= 0:
            return False

        self.__balance += amount
        return True

    def withdraw(self, amount):
        if amount <= 0 or amount > self.__balance:
            return False

        self.__balance -= amount
        return True

    def get_balance(self):
        return self.__balance
```

## Bruk av klassen

Vi oppretter en bankkonto med 1000 kroner.

```python id="g5t8nr"
account = BankAccount("Alice", 1000)
```

Vi setter inn 500 kroner:

```python id="g6e2pc"
print(account.deposit(500))
```

**Utskrift:**

```text id="j8tye2"
True
```

Vi tar ut 200 kroner:

```python id="u8p1ko"
print(account.withdraw(200))
```

**Utskrift:**

```text id="32ysje"
True
```

Vi henter saldoen:

```python id="5phh8s"
print(account.get_balance())
```

**Utskrift:**

```text id="ck5o9b"
1300
```

### Hva skjer hvis vi forsøker å ta ut for mye?

```python id="um7q0p"
print(account.withdraw(2000))
```

**Utskrift:**

```text id="r3nv08"
False
```

Metoden avviser uttaket fordi det ikke finnes nok penger på kontoen.

Saldoen forblir uendret.

```python id="9gl5cn"
print(account.get_balance())
```

**Utskrift:**

```text id="u8mnx2"
1300
```

### Hva demonstrerer eksempelet?

- Saldoen lagres i et internt attributt.
- Brukeren kan sette inn penger gjennom `deposit()`.
- Brukeren kan ta ut penger gjennom `withdraw()`.
- Metodene kontrollerer at operasjonene er gyldige.
- Brukeren trenger ikke å vite hvordan saldoen lagres internt.

Dette demonstrerer både innkapsling og abstraksjon.

**Merk:** Dette er et forenklet undervisningseksempel. I en reell bankapplikasjon ville vi også validert startsaldoen og brukt en egnet datatype for pengebeløp, for eksempel `Decimal`.

---

# 7. Forskjellen mellom abstraksjon og innkapsling

Begrepene henger sammen, men har forskjellige formål.

| Prinsipp | Forklaring | Eksempel |
|---|---|---|
| Abstraksjon | Viser hva objektet kan gjøre uten å eksponere alle implementeringsdetaljene. | `account.deposit(500)` |
| Innkapsling | Samler data og metoder og kontrollerer hvordan den interne tilstanden endres. | `self.__balance` endres gjennom `deposit()`. |

**En enkel huskeregel:**

- **Abstraksjon:** Hva kan objektet gjøre?
- **Innkapsling:** Hvordan beskytter og kontrollerer vi objektets interne tilstand?

---

# Oppsummering

Abstraksjon gjør det mulig å lage enkle og tydelige grensesnitt uten at brukeren trenger å kjenne til den interne implementasjonen.

I Python kan vi oppnå abstraksjon gjennom vanlige klasser, metoder og abstrakte baseklasser.

Innkapsling brukes for å samle data og funksjonalitet og kontrollere hvordan objektets interne tilstand endres.

De viktigste begrepene er:

| Begrep | Beskrivelse |
|---|---|
| `ABC` | Brukes til å definere en abstrakt baseklasse. |
| `@abstractmethod` | Marker en metode som må implementeres av en konkret underklasse. |
| `self._variabel` | Konvensjon for interne attributter. |
| `self.__variabel` | Aktiverer name mangling. |
| Offentlige metoder | Gir kontrollert tilgang til objektets funksjonalitet. |

**Husk:** Abstraksjon handler om å skjule unødvendig kompleksitet, mens innkapsling handler om å organisere og kontrollere tilgangen til objektets data og funksjonalitet.
