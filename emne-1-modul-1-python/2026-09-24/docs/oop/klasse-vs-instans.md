# Klassemedlemmer vs. instansmedlemmer

Når vi lager en klasse i Python, kan vi ha variabler og metoder som tilhører enten:

- **Klassen:** Deles av alle objektene som opprettes fra klassen.
- **Instansen:** Tilhører et bestemt objekt som opprettes fra klassen.

Vi skal se på forskjellen ved hjelp av en `Car`-klasse.

---

## 1. Klassevariabler (Class Variables)

En klassevariabel tilhører selve klassen og deles av alle instanser.

Vi kan for eksempel bruke en klassevariabel til å telle hvor mange biler som er opprettet.

```python
class Car:
    car_count = 0

    def __init__(self, brand):
        self.brand = brand
        Car.car_count += 1
```

Vi oppretter tre biler:

```python
car1 = Car("Volvo")
car2 = Car("BMW")
car3 = Car("Tesla")

print(Car.car_count)
```

**Utskrift:**

```text
3
```

**Hva skjer?**

- `car_count` er en klassevariabel.
- Den tilhører klassen `Car`, ikke et bestemt bilobjekt.
- Hver gang vi oppretter en bil, øker telleren med 1.
- Alle instansene har tilgang til den samme klassevariabelen.

Vi bruker `Car.car_count` for å få tilgang til variabelen gjennom klassen.

> **Merk:** En klassevariabel deles så lenge den ikke overskygges av en instansvariabel med samme navn.

---

## 2. Instansvariabler (Instance Variables)

En instansvariabel tilhører et bestemt objekt.

Instansvariabler opprettes vanligvis i konstruktøren `__init__` ved hjelp av `self`.

```python
class Car:
    def __init__(self, brand):
        self.brand = brand
```

Vi oppretter to biler:

```python
car1 = Car("Volvo")
car2 = Car("BMW")

print(car1.brand)
print(car2.brand)
```

**Utskrift:**

```text
Volvo
BMW
```

Hver bil har sin egen `brand`-variabel.

Vi kan endre merket til én bil uten at den andre påvirkes:

```python
car1.brand = "Tesla"

print(car1.brand)  # Tesla
print(car2.brand)  # BMW
```

**Husk:**
- Instansvariabler tilhører et bestemt objekt.
- De opprettes vanligvis ved hjelp av `self`.
- Hvert objekt kan ha sine egne verdier.

---

## 3. Instansmetoder (Instance Methods)

En instansmetode er en metode som tilhører et objekt.

Den bruker `self` som første parameter for å få tilgang til objektets variabler og andre metoder.

```python
class Car:
    def __init__(self, brand):
        self.brand = brand

    def get_brand(self):
        return f"Brand: {self.brand}"
```

Vi oppretter to biler og kaller metoden:

```python
car1 = Car("Volvo")
car2 = Car("BMW")

print(car1.get_brand())
print(car2.get_brand())
```

**Utskrift:**

```text
Brand: Volvo
Brand: BMW
```

Metoden er den samme, men resultatet avhenger av hvilket objekt som kaller den.

**Husk:**
- Instansmetoder bruker `self`.
- De kan lese og endre objektets instansvariabler.
- De kalles vanligvis gjennom et objekt, for eksempel `car1.get_brand()`.

---

## 4. Klassemetoder (Class Methods)

En klassemetode tilhører klassen og ikke en bestemt instans.

Vi oppretter klassemetoder ved hjelp av dekoratøren `@classmethod`.

I stedet for `self` bruker vi `cls`, som refererer til klassen.

```python
class Car:
    car_count = 0

    def __init__(self, brand):
        self.brand = brand
        Car.car_count += 1

    @classmethod
    def get_car_count(cls):
        return f"Car count: {cls.car_count}"
```

Vi oppretter to biler:

```python
car1 = Car("Volvo")
car2 = Car("BMW")

print(Car.get_car_count())
```

**Utskrift:**

```text
Car count: 2
```

**Hva skjer?**

- `@classmethod` forteller Python at dette er en klassemetode.
- `cls` refererer til klassen.
- Metoden bruker `cls.car_count` for å hente klassevariabelen.
- Vi kan kalle metoden direkte gjennom klassen.

**Husk:**
- Klassemetoder bruker `cls` i stedet for `self`.
- De kan lese og endre klassevariabler.
- De kalles vanligvis gjennom klassen, for eksempel `Car.get_car_count()`.

---

# 5. Komplett eksempel

Her kombinerer vi alle fire konseptene i én klasse.

```python
class Car:
    # Class variable
    car_count = 0

    def __init__(self, brand):
        # Instance variable
        self.brand = brand

        # Update class variable
        Car.car_count += 1

    # Instance method
    def get_brand(self):
        return f"Brand: {self.brand}"

    # Class method
    @classmethod
    def get_car_count(cls):
        return f"Car count: {cls.car_count}"


# Create objects
car1 = Car("Volvo")
car2 = Car("BMW")
car3 = Car("Tesla")

# Call instance methods
print(car1.get_brand())
print(car2.get_brand())
print(car3.get_brand())

# Call class method
print(Car.get_car_count())
```

**Utskrift:**

```text
Brand: Volvo
Brand: BMW
Brand: Tesla
Car count: 3
```

---

# 6. Oppsummering

| Type | Tilhører | Bruker | Eksempel |
|---|---|---|---|
| Klassevariabel | Klassen | Klassenavn | `Car.car_count` |
| Instansvariabel | Objektet | `self` | `self.brand` |
| Klassemetode | Klassen | `cls` | `Car.get_car_count()` |
| Instansmetode | Objektet | `self` | `car1.get_brand()` |

**En enkel huskeregel:**

- `self` = Dette objektet.
- `cls` = Denne klassen.

Klassemedlemmer brukes når informasjon eller funksjonalitet gjelder klassen som helhet.

Instansmedlemmer brukes når informasjon eller funksjonalitet gjelder et bestemt objekt.

---

# 7. Ekstra: Statiske metoder (Static Methods)

Python har også en tredje metodetype: statiske metoder.

En statisk metode tilhører klassens navnerom, men mottar verken `self` eller `cls` automatisk.

Vi oppretter slike metoder ved hjelp av `@staticmethod`.

**Eksempel:**

```python
class Car:

    @staticmethod
    def is_valid_speed(speed):
        return speed >= 0
```

Metoden kan kalles direkte gjennom klassen:

```python
print(Car.is_valid_speed(80))
print(Car.is_valid_speed(-20))
```

**Utskrift:**

```text
True
False
```

En statisk metode er nyttig når vi ønsker å samle en hjelpefunksjon i en klasse, men funksjonen ikke trenger tilgang til objektet eller klassen.

**Forskjellen mellom metodetypene:**

| Metodetype | Første parameter | Bruksområde |
|---|---|---|
| Instansmetode | `self` | Arbeide med et bestemt objekt. |
| Klassemetode | `cls` | Arbeide med klassen. |
| Statisk metode | Ingen automatisk parameter | Hjelpefunksjoner knyttet til klassen. |
