# Arv (Inheritance) i Python

Arv er et viktig prinsipp i objektorientert programmering (OOP).

**Arv betyr at en klasse kan arve attributter og metoder fra en annen klasse.**

Dette gjør at vi kan gjenbruke kode og lage mer spesialiserte klasser uten å skrive den samme koden flere ganger.

For eksempel:

- Et kjøretøy har et merke og en modell.
- En bil er et kjøretøy, men har også et antall dører.
- En lastebil er et kjøretøy, men har også en lastekapasitet.

I stedet for å definere merke og modell i alle klassene, kan vi samle disse egenskapene i en felles overklasse.

---

# 1. Overklasse og underklasse

Når vi bruker arv, skiller vi mellom to typer klasser:

| Begrep | Forklaring |
|---|---|
| Overklasse (Superclass) | Klassen vi arver fra. |
| Underklasse (Subclass) | Klassen som arver fra overklassen. |

En overklasse inneholder vanligvis egenskaper og metoder som er felles for flere klasser.

En underklasse kan arve disse og legge til egne egenskaper og metoder.

## Eksempel

Vi starter med en overklasse som heter `Vehicle`.

```python id="cq12me"
class Vehicle:
    def __init__(self, brand, model):
        self.brand = brand
        self.model = model

    def get_info(self):
        return f"{self.brand} {self.model}"
```

Deretter oppretter vi en underklasse `Car`.

```python id="2n1xej"
class Car(Vehicle):
    pass
```

Ved å skrive `Car(Vehicle)` forteller vi Python at `Car` skal arve fra `Vehicle`.

Vi kan nå opprette et bilobjekt:

```python id="8ih9p2"
car = Car("Toyota", "Corolla")

print(car.brand)
print(car.model)
print(car.get_info())
```

**Utskrift:**

```text id="vvzkli"
Toyota
Corolla
Toyota Corolla
```

Selv om vi ikke har definert noen attributter eller metoder i `Car`, kan vi bruke funksjonaliteten som er arvet fra `Vehicle`.

---

# 2. Utvide en klasse med nye egenskaper

En underklasse kan ha flere egenskaper enn overklassen.

For eksempel ønsker vi at `Car` også skal ha en variabel for antall dører.

Da kan vi lage en egen `__init__`-metode i underklassen.

```python id="jctpy3"
class Car(Vehicle):
    def __init__(self, brand, model, num_doors):
        super().__init__(brand, model)

        self.num_doors = num_doors
```

## Hva betyr `super()`?

`super()` gir oss tilgang til metoder i overklassen gjennom Pythons metodeoppslag.

I dette eksemplet bruker vi:

```python id="21o3q9"
super().__init__(brand, model)
```

Dette kaller `__init__` i `Vehicle`, slik at vi slipper å skrive koden for `brand` og `model` på nytt.

Deretter legger vi til den nye egenskapen:

```python id="0vqrg9"
self.num_doors = num_doors
```

**Eksempel på bruk:**

```python id="m8xg47"
car = Car("Toyota", "Corolla", 4)

print(car.brand)
print(car.model)
print(car.num_doors)
```

**Utskrift:**

```text id="zw73jp"
Toyota
Corolla
4
```

**Husk:** `super()` brukes ofte for å gjenbruke funksjonalitet fra overklassen.

---

# 3. Utvide en klasse med nye metoder

En underklasse kan også ha metoder som ikke finnes i overklassen.

For eksempel kan vi legge til en metode som viser antall dører.

```python id="k7o24r"
class Car(Vehicle):
    def __init__(self, brand, model, num_doors):
        super().__init__(brand, model)
        self.num_doors = num_doors

    def get_num_doors(self):
        return f"Number of doors: {self.num_doors}"
```

Vi kan nå bruke både arvede metoder og nye metoder.

```python id="7e4qkn"
car = Car("Toyota", "Corolla", 4)

print(car.get_info())
print(car.get_num_doors())
```

**Utskrift:**

```text id="qz5wpu"
Toyota Corolla
Number of doors: 4
```

`get_info()` er arvet fra `Vehicle`, mens `get_num_doors()` er definert i `Car`.

---

# 4. Metodeoverstyring (Method Overriding)

En underklasse kan lage sin egen versjon av en metode som allerede finnes i overklassen.

Dette kalles **metodeoverstyring (method overriding)**.

Vi kan for eksempel ha en generell metode for å kjøre et kjøretøy.

```python id="k0ih2a"
class Vehicle:
    def drive(self):
        return "The vehicle is driving"
```

Underklassene kan overstyre metoden.

```python id="7zvuxr"
class Car(Vehicle):
    def drive(self):
        return "The car is driving on the road"


class Truck(Vehicle):
    def drive(self):
        return "The truck is transporting goods"
```

**Eksempel på bruk:**

```python id="u9g6zw"
car = Car()
truck = Truck()

print(car.drive())
print(truck.drive())
```

**Utskrift:**

```text id="br05a8"
The car is driving on the road
The truck is transporting goods
```

Begge klassene har metoden `drive()`, men de har forskjellige implementasjoner.

**Husk:** Metodeoverstyring betyr at en underklasse erstatter en arvet metode med sin egen implementasjon.

---

# 5. Polymorfisme gjennom arv

Arv gjør det mulig å behandle forskjellige underklasser gjennom en felles overklasse.

Dette kalles **inklusjonspolymorfisme**.

Vi fortsetter med eksempelet fra forrige kapittel.

```python id="3wcv09"
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

Vi oppretter en liste med forskjellige kjøretøy.

```python id="3f4jmk"
vehicles = [
    Vehicle(),
    Car(),
    Truck()
]

for v in vehicles:
    print(v.drive())
```

**Utskrift:**

```text id="uqvj05"
The vehicle is driving
The car is driving
The truck is driving
```

Alle objektene behandles på samme måte gjennom metoden `drive()`.

Python velger riktig implementasjon basert på objektets faktiske type.

Dette er polymorfisme gjennom arv.

---

# 6. Komplett eksempel: Person, Student og Teacher

Vi skal nå lage et eksempel hvor `Student` og `Teacher` arver fra en felles overklasse `Person`.

Begge har noen felles egenskaper:

- Fornavn
- Etternavn
- Alder

Men de har også egne egenskaper:

- Student har studentnummer og studieretning.
- Lærer har ansattnummer og avdeling.

## Overklasse: Person

```python id="z2kuf0"
class Person:
    def __init__(self, first_name, last_name, age):
        self.first_name = first_name
        self.last_name = last_name
        self.age = age

    def get_info(self):
        return f"{self.first_name} {self.last_name}, {self.age} years old"
```

## Underklasse: Student

```python id="3ax0fy"
class Student(Person):
    def __init__(self, first_name, last_name, age, student_id, major):
        super().__init__(first_name, last_name, age)

        self.student_id = student_id
        self.major = major

    def get_info(self):
        return (
            f"Student: {self.first_name} {self.last_name}, "
            f"ID: {self.student_id}, Major: {self.major}"
        )
```

## Underklasse: Teacher

```python id="7ezr6b"
class Teacher(Person):
    def __init__(self, first_name, last_name, age, employee_id, department):
        super().__init__(first_name, last_name, age)

        self.employee_id = employee_id
        self.department = department

    def get_info(self):
        return (
            f"Teacher: {self.first_name} {self.last_name}, "
            f"ID: {self.employee_id}, Department: {self.department}"
        )
```

## Bruk av klassene

```python id="j2b5wm"
student = Student(
    "Alice",
    "Larsen",
    20,
    "S12345",
    "Computer Science"
)

teacher = Teacher(
    "Bob",
    "Johansen",
    45,
    "T67890",
    "Mathematics"
)

print(student.get_info())
print(teacher.get_info())
```

**Utskrift:**

```text id="yd7a1w"
Student: Alice Larsen, ID: S12345, Major: Computer Science
Teacher: Bob Johansen, ID: T67890, Department: Mathematics
```

## Hva demonstrerer eksempelet?

1. `Student` og `Teacher` arver fra `Person`.
2. Begge gjenbruker initialiseringen fra `Person` ved hjelp av `super()`.
3. Begge legger til egne instansvariabler.
4. Begge overstyrer metoden `get_info()`.

Vi oppnår dermed både kodegjenbruk og polymorfisme.

---

# 7. Når bør vi bruke arv?

Arv er nyttig når vi har en tydelig **«er en»-relasjon (is-a)**.

Eksempler:

- En bil er et kjøretøy.
- En hund er et dyr.
- En student er en person.

Vi bør derimot være forsiktige med å bruke arv bare for å gjenbruke kode.

Hvis forholdet er **«har en» (has-a)**, kan komposisjon være et bedre alternativ.

Eksempel:

- En bil har en motor.
- En student har en adresse.

En motor er ikke en bil, og bør derfor normalt ikke arve fra `Car`.

---

# Oppsummering

| Begrep | Forklaring |
|---|---|
| Arv | En klasse arver attributter og metoder fra en annen klasse. |
| Overklasse | Klassen vi arver fra. |
| Underklasse | Klassen som arver fra overklassen. |
| `super()` | Gir tilgang til metoder i overklassen gjennom metodeoppslag. |
| Metodeoverstyring | En underklasse lager sin egen implementasjon av en arvet metode. |
| Polymorfisme | Forskjellige objekter kan behandles gjennom et felles grensesnitt. |

## Hvorfor bruker vi arv?

- **Kodegjenbruk:** Vi slipper å skrive samme kode flere ganger.
- **Utvidelse:** Underklasser kan legge til egne attributter og metoder.
- **Spesialisering:** Underklasser kan overstyre metoder.
- **Struktur:** Vi kan organisere klasser i tydelige hierarkier.
- **Polymorfisme:** Forskjellige underklasser kan brukes gjennom en felles overklasse.

**Husk:** Arv lar oss lage nye klasser basert på eksisterende klasser, slik at vi kan gjenbruke, utvide og tilpasse funksjonalitet.
