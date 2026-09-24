# Innebygde funksjoner i Python – forklaringer og eksempler

Et oppslagsverk for Python-undervisning. **Innebygde funksjoner** kan brukes uten `import`. Eksemplene er laget for Python 3.

## Innhold

1. [Tall og beregninger](#1-tall-og-beregninger)
2. [Iterasjon og sekvenser](#2-iterasjon-og-sekvenser)
3. [Sortering og filtrering](#3-sortering-og-filtrering)
4. [Datatyper og konvertering](#4-datatyper-og-konvertering)
5. [Input, output og filer](#5-input-output-og-filer)
6. [Objekter og OOP](#6-objekter-og-oop)
7. [Flere nyttige funksjoner](#7-flere-nyttige-funksjoner)
8. [Vanlige misforståelser](#8-vanlige-misforståelser)

---

## 1. Tall og beregninger

### `abs(x)` – absoluttverdi
Returnerer avstanden fra null, uten fortegn.

```python
print(abs(-12))  # 12
```

### `round(number, ndigits=0)` – avrunding
Avrunder et tall. Python bruker avrunding til nærmeste partall ved eksakte halvveisverdier; flyttall kan også gi overraskelser på grunn av binær representasjon.

```python
print(round(3.14159, 2))  # 3.14
print(round(2.5))         # 2
```

### `sum(iterable, start=0)` – summering
Legger sammen tallene i en itererbar samling.

```python
print(sum([2, 4, 6]))  # 12
```

### `min(...)` og `max(...)` – minste og største verdi
Kan brukes på en samling eller flere argumenter. Tomme samlinger gir `ValueError` med mindre du oppgir `default` for iterable-varianten.

```python
print(min([8, 3, 9]))  # 3
print(max(8, 3, 9))    # 9
print(min([], default=None))  # None
```

### `pow(base, exp[, mod])` – potens
Beregner potens. Med tre heltallsargumenter beregnes modulær potens effektivt.

```python
print(pow(2, 3))      # 8
print(pow(2, 3, 5))   # 3
```

### `divmod(a, b)` – kvotient og rest
Returnerer en tuple `(a // b, a % b)`.

```python
print(divmod(17, 5))  # (3, 2)
```

---

## 2. Iterasjon og sekvenser

### `len(obj)` – antall elementer
Gir lengden på for eksempel en streng, liste eller ordbok.

```python
print(len("Python"))     # 6
print(len([1, 2, 3]))  # 3
```

### `range(start, stop, step)` – tallsekvens
Lager et `range`-objekt. `stop` er **ikke inkludert**. `start` er valgfri og er 0 som standard.

```python
print(list(range(1, 6)))     # [1, 2, 3, 4, 5]
print(list(range(0, 6, 2)))  # [0, 2, 4]
```

### `enumerate(iterable, start=0)` – indeks og verdi
Gir `(indeks, verdi)` for hvert element. Praktisk når du trenger nummerering.

```python
for number, name in enumerate(["Ada", "Bo"], start=1):
    print(number, name)
# 1 Ada
# 2 Bo
```

### `zip(*iterables)` – kombiner samlinger
Kobler sammen elementer på samme posisjon. Stopper normalt ved den korteste samlingen. `strict=True` kan brukes når ulik lengde skal gi feil (Python 3.10+).

```python
print(list(zip(["Ada", "Bo"], [5, 4])))
# [('Ada', 5), ('Bo', 4)]
```

### `reversed(seq)` – omvendt rekkefølge
Gir en iterator over elementene baklengs. **Sorterer ikke**.

```python
print(list(reversed([3, 1, 2])))  # [2, 1, 3]
print("".join(reversed("hello")))  # olleh
```

### `iter(obj)` og `next(iterator, default)` – iteratorer
`iter()` henter en iterator; `next()` henter neste verdi. Uten en standardverdi gir en oppbrukt iterator `StopIteration`.

```python
it = iter([10, 20])
print(next(it))          # 10
print(next(it))          # 20
print(next(it, "done"))  # done
```

---

## 3. Sortering og filtrering

### `sorted(iterable, key=None, reverse=False)` – sorter
Returnerer en **ny liste**. Originalen endres ikke. `key` bestemmer hva det sorteres etter.

```python
words = ["cat", "elephant", "mouse"]
print(sorted(words, key=len))           # ['cat', 'mouse', 'elephant']
print(sorted([3, 1, 2], reverse=True)) # [3, 2, 1]
```

### `filter(function, iterable)` – velg elementer
Returnerer en iterator med elementer som oppfyller betingelsen. Bruk `list()` hvis du trenger en liste.

```python
numbers = [1, 2, 3, 4]
print(list(filter(lambda x: x % 2 == 0, numbers)))  # [2, 4]
```

### `map(function, *iterables)` – transformer elementer
Bruker en funksjon på hvert element og returnerer en iterator. Med flere samlinger stopper den ved den korteste.

```python
print(list(map(str, [1, 2, 3])))  # ['1', '2', '3']
print(list(map(lambda a, b: a + b, [1, 2], [10, 20])))  # [11, 22]
```

### `any(iterable)` – minst én sann verdi
Returnerer `True` hvis minst ett element er sannhetsverdi `True`. For en tom samling returneres `False`.

```python
print(any(x < 0 for x in [2, -1, 5]))  # True
```

### `all(iterable)` – alle sanne
Returnerer `True` hvis alle elementene er sanne. For en tom samling returneres `True`.

```python
print(all(x > 0 for x in [2, 4, 6]))  # True
```

---

## 4. Datatyper og konvertering

### `int(x)` – konverter til heltall
Kan konvertere tall og gyldige tallstrenger. `int()` trunkerer flyttall mot null; ugyldige strenger gir `ValueError`.

```python
print(int("42"))  # 42
print(int(3.9))   # 3
```

### `float(x)` – konverter til flyttall
Brukes for desimaltall. Python forventer normalt punktum i en tallstreng.

```python
print(float("3.5"))  # 3.5
```

### `str(obj)` – tekstrepresentasjon
Konverterer en verdi til en streng.

```python
print("Age: " + str(20))  # Age: 20
```

### `bool(x)` – sannhetsverdi
Konverterer til `True` eller `False`. Tomme samlinger, null og tom streng er falske. **Strengen `"False"` er sann**, fordi den ikke er tom.

```python
print(bool(0))        # False
print(bool("False"))  # True
```

### `list()`, `tuple()`, `set()` og `dict()` – opprett samlinger
`list` er endringsbar og ordnet; `tuple` er uforanderlig; `set` inneholder unike elementer; `dict` kobler nøkler til verdier.

```python
print(list("abc"))                   # ['a', 'b', 'c']
print(tuple([1, 2]))                 # (1, 2)
print(set([1, 1, 2]))                # {1, 2} (visningsrekkefølge kan variere)
print(dict([("name", "Ada")]))       # {'name': 'Ada'}
```

### `type(obj)` – faktisk type
Returnerer objektets type.

```python
print(type(42))  # <class 'int'>
```

### `isinstance(obj, classinfo)` – typekontroll med arv
Sjekker om objektet er en instans av klassen eller en underklasse. Merk at `bool` er en underklasse av `int`.

```python
print(isinstance(42, int))    # True
print(isinstance(True, int))  # True
```

---

## 5. Input, output og filer

### `print(*objects, sep=' ', end='\n')` – skriv ut
Skriver verdier til standardutdata. `sep` angir skilletegn, og `end` angir avslutning.

```python
print("Ada", "Bo", sep=" | ")  # Ada | Bo
```

### `input(prompt)` – les tekst fra brukeren
Returnerer **alltid en streng**. Konverter til tall ved behov, og håndter feil.

```python
try:
    age = int(input("Age: "))
    print(age)
except ValueError:
    print("Please enter an integer.")
```

### `open(file, mode='r', encoding=...)` – åpne fil
Returnerer et filobjekt. Bruk helst `with` slik at filen lukkes automatisk. Vanlige moduser: `r` les, `w` skriv/overskriv, `a` legg til.

```python
with open("numbers.txt", "w", encoding="utf-8") as file:
    file.write("1\n2\n3\n")

with open("numbers.txt", "r", encoding="utf-8") as file:
    for line in file:
        print(line.strip())
```

---

## 6. Objekter og OOP

### `getattr(obj, name[, default])` – hent attributt etter navn
Nyttig når attributtnavnet kommer som en streng. Med `default` unngår du `AttributeError` dersom attributtet mangler.

```python
class Student:
    def __init__(self, name):
        self.name = name

student = Student("Ada")
print(getattr(student, "name"))              # Ada
print(getattr(student, "age", "Unknown"))    # Unknown
```

### `hasattr(obj, name)` – finnes attributtet?
Returnerer en boolsk verdi. Hvis du skal kalle attributtet som metode, kan du i tillegg sjekke `callable()`.

```python
print(hasattr(student, "name"))  # True
```

### `setattr(obj, name, value)` – sett attributt
Oppretter eller endrer et attributt ved navn.

```python
setattr(student, "age", 20)
print(student.age)  # 20
```

### `delattr(obj, name)` – fjern attributt
Sletter et attributt dersom det finnes og kan slettes.

```python
delattr(student, "age")
print(hasattr(student, "age"))  # False
```

### `callable(obj)` – kan objektet kalles?
Sjekker om objektet kan brukes med parenteser, som en funksjon eller metode. Det garanterer ikke at et kall med vilkårlige argumenter lykkes.

```python
print(callable(len))  # True
print(callable(42))   # False
```

### `super()` – tilgang til metoder i arv
Brukes ofte til å kalle overklassens initialisering. Ved multippel arv følger metodeoppslaget klassens MRO (method resolution order).

```python
class Person:
    def __init__(self, name):
        self.name = name

class Student(Person):
    def __init__(self, name, student_id):
        super().__init__(name)
        self.student_id = student_id
```

---

## 7. Flere nyttige funksjoner

### `ord(char)` og `chr(code)` – tegn og Unicode-kodepunkt
`ord()` gir kodepunktet til ett tegn; `chr()` gjør det motsatte.

```python
print(ord("A"))  # 65
print(chr(65))   # A
```

### `bin()`, `oct()` og `hex()` – tallbaser
Returnerer strengrepresentasjoner av et heltall i henholdsvis binær, oktal og heksadesimal form.

```python
print(bin(10))  # 0b1010
print(oct(10))  # 0o12
print(hex(10))  # 0xa
```

### `format(value, format_spec)` – formater en verdi
Brukes for eksempel til desimaler. F-strenger tilbyr samme formateringssyntaks på en lesbar måte.

```python
print(format(3.14159, ".2f"))  # 3.14
print(f"{3.14159:.2f}")        # 3.14
```

### `id(obj)` – identitet
Returnerer et heltall som identifiserer objektet mens det eksisterer. Ikke bruk verdien som permanent ID.

```python
obj = []
print(id(obj))  # An integer; varies between runs
```

### `help(obj)` og `dir(obj)` – utforsk Python
`help()` viser dokumentasjon; `dir()` gir en liste med navn som er tilgjengelige på objektet (ikke nødvendigvis uttømmende for dynamiske attributter).

```python
help(len)
print(dir("hello"))  # List of string methods
```

---

## 8. Vanlige misforståelser

| Tema | Viktig å huske |
|---|---|
| `sorted()` vs. `reversed()` | `sorted()` sorterer; `reversed()` snur eksisterende rekkefølge. |
| `sorted()` vs. `list.sort()` | `sorted()` lager en ny liste; `list.sort()` endrer listen på stedet og returnerer `None`. |
| `map()`, `filter()` og `zip()` | Returnerer iteratorer i Python 3. Bruk `list(...)` når du trenger en liste. |
| `zip()` med ulik lengde | Stopper ved korteste samling som standard. |
| `input()` | Returnerer streng, selv når brukeren skriver tall. |
| `type()` vs. `isinstance()` | `type()` gir den konkrete typen; `isinstance()` tar også hensyn til arv. |
| `bool("False")` | Er `True` fordi strengen ikke er tom. |
| `all([])` og `any([])` | Gir henholdsvis `True` og `False`. |
| `round()` | Ikke bruk vanlig binært flyttall som eneste grunnlag for presise pengeutregninger; vurder `decimal.Decimal`. |
| Innebygde funksjoner vs. metoder | `len(liste)` er en innebygd funksjon; `liste.append(x)` er en metode. |

## Videre lesning

Offisiell Python-dokumentasjon: https://docs.python.org/3/library/functions.html

**Tips til undervisning:** Be studentene forklare returtypen til hver funksjon, forutsi utskriften før de kjører eksempelet, og lage minst ett eksempel som håndterer ugyldige data.
