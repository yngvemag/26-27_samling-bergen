# Polymorfisme i Python

Polymorfisme betyr **«mange former»** og er et viktig prinsipp i objektorientert programmering (OOP).

Det betyr at forskjellige objekter kan bruke samme metode, men utføre den på forskjellige måter.

**Eksempel:** En hund, katt og and kan alle lage lyd, men lydene er forskjellige.

```python
class Dog:
    def speak(self):
        return "Woof!"

class Cat:
    def speak(self):
        return "Meow!"

class Duck:
    def speak(self):
        return "Quack!"
```

Alle klassene har metoden `speak()`, men de har forskjellige implementasjoner.

```python
animals = [Dog(), Cat(), Duck()]

for a in animals:
    print(a.speak())
```

**Utskrift:**

```text
Woof!
Meow!
Quack!
```

Vi bruker den samme metoden `speak()` på forskjellige objekter, uten å måtte sjekke hvilken type objekt vi har.

Dette er polymorfisme!

---

# Hvordan oppnår vi polymorfisme i Python?

Det finnes flere måter å oppnå polymorfisme på. Vi skal se på tre sentrale konsepter.

## 1. Method Overriding (metodeoverstyring)

Metodeoverstyring betyr at en underklasse lager sin egen versjon av en metode som allerede finnes i en overklasse.

**Eksempel:**

```python
class Vehicle:
    def drive(self):
        return "The vehicle is driving"

class Car(Vehicle):
    def drive(self):
        return "The car is driving"

class Truck(Vehicle):
    def drive(self):
        return "The truck is driving"
```

Her arver `Car` og `Truck` fra `Vehicle`, men begge overstyrer metoden `drive()`.

```python
vehicles = [Vehicle(), Car(), Truck()]

for v in vehicles:
    print(v.drive())
```

**Utskrift:**

```text
The vehicle is driving
The car is driving
The truck is driving
```

**Hva skjer?**

- Alle objektene har metoden `drive()`.
- Underklassene har sine egne implementasjoner.
- Python velger riktig metode basert på objektets faktiske type.

Dette er polymorfisme gjennom arv og metodeoverstyring.

---

## 2. Duck Typing

I Python trenger ikke klasser å arve fra samme overklasse for å oppnå polymorfisme.

Det er tilstrekkelig at objektene har metodene vi ønsker å bruke.

Dette kalles **duck typing**.

Uttrykket kommer fra:

> If it walks like a duck and quacks like a duck, it's a duck.

Med andre ord: Vi bryr oss ikke nødvendigvis om hvilken klasse objektet tilhører, men hva objektet kan gjøre.

**Eksempel:**

```python
class Dog:
    def speak(self):
        return "Woof!"

class Cat:
    def speak(self):
        return "Meow!"

def make_sound(animal):
    print(animal.speak())
```

Vi kan sende inn forskjellige objekter:

```python
make_sound(Dog())
make_sound(Cat())
```

**Utskrift:**

```text
Woof!
Meow!
```

Funksjonen `make_sound()` fungerer med begge klassene fordi begge har metoden `speak()`.

**Viktig:** Klassene trenger ikke å ha noen relasjon til hverandre gjennom arv.

Dette er en vanlig måte å oppnå polymorfisme på i Python.

---

## 3. Method Overloading (metodeoverbelastning)

Metodeoverbelastning betyr at flere metoder har samme navn, men forskjellige parametere.

Dette er vanlig i programmeringsspråk som C# og Java.

Python støtter ikke tradisjonell metodeoverbelastning på samme måte, men vi kan oppnå lignende funksjonalitet med standardargumenter.

**Eksempel:**

```python
def greet(name=None):
    if name:
        print(f"Hello, {name}!")
    else:
        print("Hello!")
```

Vi kan nå kalle funksjonen på forskjellige måter:

```python
greet()
greet("Alice")
```

**Utskrift:**

```text
Hello!
Hello, Alice!
```

Funksjonen kan brukes både med og uten argument.

**Merk:** Dette er ikke ekte metodeoverbelastning, men en alternativ måte å oppnå lignende funksjonalitet på i Python.

---

# Oppsummering

Polymorfisme betyr at vi kan bruke samme metode eller grensesnitt med forskjellige objekter.

| Konsept | Forklaring |
|---|---|
| Polymorfisme | Samme metode kan gi forskjellig oppførsel avhengig av objektet. |
| Method Overriding | En underklasse lager sin egen versjon av en metode fra overklassen. |
| Duck Typing | Objekter kan brukes på samme måte dersom de har de nødvendige metodene. |
| Method Overloading | Flere metoder med samme navn, men forskjellige parametere. Ikke direkte støttet i Python. |

## Hvorfor bruker vi polymorfisme?

- **Mindre kode:** Vi slipper å skrive separate funksjoner for hver objekttype.
- **Fleksibilitet:** Nye klasser kan legges til uten å endre eksisterende kode som bruker det felles grensesnittet.
- **Enklere vedlikehold:** Vi kan endre implementasjonen i én klasse uten å påvirke de andre.
- **Bedre struktur:** Vi kan fokusere på hva objektene kan gjøre, fremfor hvilken klasse de tilhører.

**Husk:** Polymorfisme handler om at forskjellige objekter kan behandles gjennom et felles grensesnitt, samtidig som de kan ha forskjellig oppførsel.
