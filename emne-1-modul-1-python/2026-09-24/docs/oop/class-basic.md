# Komponenter i en klasse i Python

En klasse er en **mal for å opprette objekter**.

Klassen beskriver hvilke egenskaper (attributter) og handlinger (metoder) objektene skal ha.

For eksempel kan vi lage en klasse `Car` som beskriver hva en bil skal inneholde og hva den kan gjøre.

En klasse består vanligvis av følgende komponenter:

1. Klassenavn
2. Attributter (variabler)
3. Metoder
4. Initialisering med `__init__`
5. Spesielle metoder

---

## 1. Klassenavn

Klassenavnet forteller hva klassen representerer.

I Python bruker vi vanligvis **PascalCase**, som betyr at hvert ord starter med stor bokstav.

```python
class Car:
    pass

class BankAccount:
    pass

class StudentRegister:
    pass
```

`pass` brukes når vi ønsker å opprette en klasse uten å legge til innhold ennå.

---

## 2. Attributter (variabler)

Attributter beskriver egenskapene til et objekt.

For eksempel kan en bil ha:
- Merke
- Modell
- Årsmodell

I Python skiller vi mellom to typer variabler.

### Instansvariabler

Instansvariabler tilhører et bestemt objekt.

```python
class Car:
    def __init__(self, brand, model):
        self.brand = brand
        self.model = model
```

Vi kan opprette to forskjellige biler:

```python
car1 = Car("Toyota", "Corolla")
car2 = Car("Tesla", "Model S")

print(car1.brand)  # Toyota
print(car2.brand)  # Tesla
```

Hver bil har sine egne verdier for `brand` og `model`.

### Klassevariabler

Klassevariabler tilhører klassen og deles normalt av alle instanser.

```python
class Car:
    car_count = 0

    def __init__(self, brand):
        self.brand = brand
        Car.car_count += 1
```

```python
car1 = Car("Toyota")
car2 = Car("Tesla")

print(Car.car_count)  # 2
```

Klassevariabelen `car_count` holder oversikt over hvor mange biler som er opprettet.

---

## 3. Metoder

Metoder er funksjoner som er definert inne i en klasse.

De beskriver hva objektene kan gjøre.

### Instansmetoder

Instansmetoder bruker `self` for å få tilgang til objektets attributter.

```python
class Car:
    def __init__(self, brand):
        self.brand = brand

    def get_info(self):
        print(f"Brand: {self.brand}")
```

Vi kan kalle metoden gjennom et objekt:

```python
car = Car("Toyota")

car.get_info()
```

**Utskrift:**

```text
Brand: Toyota
```

### Andre metodetyper

Python har også to andre metodetyper:

| Metodetype | Beskrivelse |
|---|---|
| Instansmetode | Bruker `self` og arbeider med objektet. |
| Klassemetode | Bruker `@classmethod` og `cls` for å arbeide med klassen. |
| Statisk metode | Bruker `@staticmethod` og trenger verken `self` eller `cls`. |

Klassemetoder og statiske metoder kan introduseres når vi trenger dem.

---

## 4. Initialisering med `__init__`

Metoden `__init__` blir automatisk kalt når et nytt objekt opprettes.

Vi bruker den vanligvis til å gi objektet startverdier.

```python
class Car:
    def __init__(self, brand, model, year):
        self.brand = brand
        self.model = model
        self.year = year
```

Når vi oppretter et objekt:

```python
car = Car("Toyota", "Corolla", 2020)
```

Blir verdiene lagret i objektets instansvariabler.

```python
print(car.brand)   # Toyota
print(car.model)   # Corolla
print(car.year)    # 2020
```

**Husk:**

- `__init__` brukes til å initialisere objektet.
- `self` refererer til objektet som initialiseres.
- Parametrene bestemmer hvilke verdier vi kan sende inn når objektet opprettes.

Teknisk sett opprettes objektet av `__new__`, mens `__init__` initialiserer det. I grunnleggende OOP-undervisning omtales `__init__` ofte som konstruktøren.

---

# 5. Standardverdier i `__init__`

Noen ganger ønsker vi at enkelte parametere skal være valgfrie.

Dette kan vi løse med standardverdier.

```python
class Car:
    def __init__(self, brand, model, year=None):
        self.brand = brand
        self.model = model
        self.year = year
```

Nå kan vi opprette objekter med forskjellige antall argumenter:

```python
car1 = Car("Toyota", "Corolla", 2020)

car2 = Car("Tesla", "Model S")
```

For `car2` vil `year` få verdien `None`.

Vi kan også gi parameteren en annen standardverdi:

```python
class Car:
    def __init__(self, brand, model, year="Unknown"):
        self.brand = brand
        self.model = model
        self.year = year
```

Dette gir fleksibilitet uten at vi trenger flere konstruktører.

---

# 6. Spesielle metoder (Dunder Methods)

Python har spesielle metoder som starter og slutter med to understreker (`__`).

Disse kalles ofte **dunder methods**, som er en forkortelse for *double underscore*.

Eksempler:

- `__init__`: Initialiserer et objekt.
- `__str__`: Bestemmer hvordan objektet vises som en lesbar streng.
- `__repr__`: Gir en representasjon av objektet, ofte brukt til debugging.
- `__del__`: En sluttbehandlingsmetode som kan kalles når et objekt skal destrueres.

Vi skal se nærmere på `__str__` og `__repr__`.

## 6.1 `__str__` – Lesbar utskrift av objekter

Når vi skriver ut et objekt med `print()`, ønsker vi ofte en forståelig beskrivelse.

Dette kan vi bestemme med `__str__`.

```python
class Car:
    def __init__(self, brand, model):
        self.brand = brand
        self.model = model

    def __str__(self):
        return f"Car: {self.brand} {self.model}"
```

```python
car = Car("Tesla", "Model S")

print(car)
```

**Utskrift:**

```text
Car: Tesla Model S
```

Uten en egen `__str__`-metode vil Python normalt vise en standardrepresentasjon av objektet.

---

## 6.2 `__repr__` – Representasjon for utviklere

`__repr__` brukes til å lage en representasjon av objektet som er nyttig ved debugging.

Ideelt sett skal representasjonen være tydelig og gjerne kunne brukes til å rekonstruere objektet.

```python
class Car:
    def __init__(self, brand, model):
        self.brand = brand
        self.model = model

    def __repr__(self):
        return f"Car({self.brand!r}, {self.model!r})"
```

```python
car = Car("Tesla", "Model S")

print(repr(car))
```

**Utskrift:**

```text
Car('Tesla', 'Model S')
```

**Forskjellen:**

| Metode | Formål |
|---|---|
| `__str__` | Lesbar tekst for brukeren. |
| `__repr__` | Tydelig representasjon for utviklere og debugging. |

---

# 7. Alternative konstruktører med `@classmethod`

Noen ganger ønsker vi å opprette objekter på forskjellige måter.

For eksempel kan vi ønske å opprette en bil fra en ordbok (`dict`).

Dette kan vi gjøre med en klassemetode.

```python
class Car:
    def __init__(self, brand, model, year):
        self.brand = brand
        self.model = model
        self.year = year

    @classmethod
    def from_dict(cls, data):
        return cls(
            data["brand"],
            data["model"],
            data.get("year", "Unknown")
        )
```

Vi kan opprette en bil på vanlig måte:

```python
car1 = Car("Toyota", "Corolla", 2020)
```

Eller fra en ordbok:

```python
data = {
    "brand": "Ford",
    "model": "Mustang",
    "year": 1964
}

car2 = Car.from_dict(data)
```

Begge metodene oppretter et `Car`-objekt.

**Merk:** `from_dict()` er en alternativ konstruktør, ikke tradisjonell metodeoverbelastning.

---

# 8. Komplett eksempel på en klasse

Her samler vi de viktigste komponentene i én klasse.

```python
class Car:

    # Class variable
    car_count = 0

    # Initialization
    def __init__(self, brand, model, year):
        self.brand = brand
        self.model = model
        self.year = year

        Car.car_count += 1

    # Instance method
    def get_info(self):
        print(f"{self.brand} {self.model} ({self.year})")

    # Class method
    @classmethod
    def get_count(cls):
        print(f"Car count: {cls.car_count}")

    # Special method
    def __str__(self):
        return f"{self.brand} {self.model}"
```

**Bruk av klassen:**

```python
car1 = Car("Toyota", "Corolla", 2020)
car2 = Car("Tesla", "Model S", 2023)

car1.get_info()
car2.get_info()

Car.get_count()

print(car1)
```

**Utskrift:**

```text
Toyota Corolla (2020)
Tesla Model S (2023)
Car count: 2
Toyota Corolla
```

---

# Oppsummering

En klasse er en mal som beskriver hvordan objekter skal se ut og oppføre seg.

| Komponent | Beskrivelse | Eksempel |
|---|---|---|
| Klassenavn | Navnet på klassen | `class Car:` |
| Instansvariabel | Egenskap som tilhører et objekt | `self.brand` |
| Klassevariabel | Variabel som deles på klassenivå | `Car.car_count` |
| Instansmetode | Metode som arbeider med objektet | `get_info(self)` |
| Klassemetode | Metode som arbeider med klassen | `@classmethod` |
| Statisk metode | Hjelpefunksjon organisert i klassen | `@staticmethod` |
| Initialisering | Gir objektet startverdier | `__init__` |
| Spesiell metode | Tilpasser objektets oppførsel | `__str__` |

**Det viktigste å huske:**

En klasse definerer hvilke attributter og metoder objektene skal ha. Når vi oppretter et objekt fra klassen, får vi en instans som kan ha sine egne verdier og utføre metodene som klassen definerer.
