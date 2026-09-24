# Type-hinting i Python

Type-hinting (type-annotasjoner) er en måte å spesifisere hvilken datatype en variabel, parameter eller returverdi forventes å ha.

**Python er dynamisk typet, men type-hints gjør koden mer lesbar og lettere å feilsøke.**

Type-hints er veiledende — Python tvinger dem ikke frem under kjøring. Verktøy som `mypy` og moderne IDE-er (f.eks. VS Code) bruker dem til å varsle om feil.

---

# 1. Type-hints på variabler

Vi kan annotere variabler med en forventet type.

```python
name: str = "Alice"
age: int = 25
height: float = 1.75
active: bool = True
```

Dette forteller andre utviklere (og verktøy) hva slags verdi variabelen skal inneholde.

---

# 2. Type-hints på funksjoner

Type-hints er spesielt nyttige på funksjoner, der vi annoterer parametere og returverdi.

## Syntaks

```python
def function_name(parameter: type) -> return_type:
    ...
```

## Eksempel

```python
def greet(name: str) -> str:
    return f"Hello, {name}!"

print(greet("Bob"))
```

**Utskrift:**

```text
Hello, Bob!
```

Her sier vi at `name` skal være en `str`, og at funksjonen returnerer en `str`.

---

# 3. Flere parametre og returverdier

```python
def add(a: int, b: int) -> int:
    return a + b


def calculate_area(width: float, height: float) -> float:
    return width * height
```

**Eksempel på bruk:**

```python
print(add(3, 5))
print(calculate_area(4.5, 2.0))
```

**Utskrift:**

```text
8
9.0
```

---

# 4. Ingen returverdi: `None`

Hvis en funksjon ikke returnerer noe, bruker vi `None` som returtype.

```python
def print_message(msg: str) -> None:
    print(msg)
```

Dette tilsvarer funksjoner som ikke har en `return`-setning, eller som bare returnerer `None`.

---

# 5. Samlinger: `list`, `dict`, `tuple`, `set`

Fra Python 3.9 kan vi bruke innebygde samlingstyper direkte som type-hints.

## Lister

```python
def sum_list(numbers: list[int]) -> int:
    return sum(numbers)
```

## Ordbøker

```python
def show_info(data: dict[str, int]) -> None:
    for key, value in data.items():
        print(f"{key}: {value}")
```

## Tupler

```python
def get_coordinates() -> tuple[float, float]:
    return (59.9, 10.7)
```

## Sett

```python
def unique_values(numbers: list[int]) -> set[int]:
    return set(numbers)
```

**Husk:** I Python 3.8 og eldre måtte man importere `List`, `Dict`, `Tuple`, `Set` fra `typing`-modulen. Fra 3.9 bruker vi de innebygde typene med liten forbokstav.

---

# 6. Valgfrie verdier: `Optional`

Noen ganger kan en verdi enten ha en type, eller være `None`. Da bruker vi `Optional`.

```python
from typing import Optional


def find_user(user_id: int) -> Optional[str]:
    users = {1: "Alice", 2: "Bob"}
    return users.get(user_id)
```

**Eksempel på bruk:**

```python
print(find_user(1))
print(find_user(99))
```

**Utskrift:**

```text
Alice
None
```

Fra Python 3.10 kan vi bruke `str | None` i stedet for `Optional[str]`.

```python
def find_user(user_id: int) -> str | None:
    users = {1: "Alice", 2: "Bob"}
    return users.get(user_id)
```

---

# 7. Union-typer: flere mulige typer

Noen ganger kan en parameter eller returverdi ha én av flere typer. Da bruker vi `Union` eller `|`-operatoren (Python 3.10+).

```python
from typing import Union


def convert(value: Union[int, str]) -> str:
    return str(value)
```

**Med ny syntaks (Python 3.10+):**

```python
def convert(value: int | str) -> str:
    return str(value)
```

---

# 8. Type-hints i klasser

Type-hints brukes ofte i klasser for å tydeliggjøre hvilke attributter en klasse har.

```python
class Person:
    def __init__(self, name: str, age: int) -> None:
        self.name: str = name
        self.age: int = age

    def describe(self) -> str:
        return f"{self.name}, {self.age} years old"
```

**Eksempel på bruk:**

```python
p = Person("Alice", 30)
print(p.describe())
```

**Utskrift:**

```text
Alice, 30 years old
```

---

# 9. `typing`-modulen

`typing`-modulen inneholder flere nyttige typer for mer avansert type-hinting.

| Type | Beskrivelse | Eksempel |
|---|---|---|
| `Optional[X]` | Enten `X` eller `None`. | `Optional[str]` |
| `Union[X, Y]` | Enten `X` eller `Y`. | `Union[int, str]` |
| `List[X]` | Liste med elementer av type `X`. | `List[int]` |
| `Dict[K, V]` | Ordbok med nøkkel `K` og verdi `V`. | `Dict[str, int]` |
| `Tuple[X, Y]` | Tuppel med angitte typer. | `Tuple[int, str]` |
| `Callable` | En funksjon eller kallbar. | `Callable[[int], str]` |
| `Any` | Hvilken som helst type (deaktiverer sjekk). | `Any` |

**Husk:** Fra Python 3.9+ kan `List`, `Dict`, `Tuple` erstattes med `list`, `dict`, `tuple`.

---

# 10. Komplett eksempel: Studentregister

Vi lager et enkelt studentregister med type-hints gjennom hele koden.

```python
from typing import Optional


class Student:
    def __init__(self, name: str, student_id: str, grade: Optional[float] = None) -> None:
        self.name: str = name
        self.student_id: str = student_id
        self.grade: Optional[float] = grade

    def set_grade(self, grade: float) -> None:
        self.grade = grade

    def get_info(self) -> str:
        if self.grade is not None:
            return f"{self.name} ({self.student_id}) – Grade: {self.grade}"
        return f"{self.name} ({self.student_id}) – No grade yet"


def find_best_student(students: list[Student]) -> Optional[Student]:
    with_grade = [s for s in students if s.grade is not None]
    if not with_grade:
        return None
    return max(with_grade, key=lambda s: s.grade)
```

**Bruk av koden:**

```python
students: list[Student] = [
    Student("Alice", "S001"),
    Student("Bob", "S002"),
    Student("Charlie", "S003"),
]

students[0].set_grade(5.5)
students[1].set_grade(4.0)
students[2].set_grade(6.0)

for student in students:
    print(student.get_info())

best = find_best_student(students)
if best:
    print(f"\nBest student: {best.name}")
```

**Utskrift:**

```text
Alice (S001) – Grade: 5.5
Bob (S002) – Grade: 4.0
Charlie (S003) – Grade: 6.0

Best student: Charlie
```

---

# Oppsummering

| Begrep | Forklaring |
|---|---|
| Type-hint | En annotasjon som angir forventet datatype. |
| `->` | Angir returtypen til en funksjon. |
| `Optional[X]` | Verdien kan være `X` eller `None`. |
| `Union[X, Y]` | Verdien kan være `X` eller `Y`. |
| `list[X]` | Liste med elementer av type `X` (Python 3.9+). |
| `dict[K, V]` | Ordbok med nøkkel `K` og verdi `V` (Python 3.9+). |
| `None` som returtype | Funksjonen returnerer ingenting. |
| `typing`-modulen | Inneholder avanserte type-konstruksjoner. |

## Hvorfor bruker vi type-hinting?

- **Lesbarhet:** Det blir umiddelbart tydelig hva en funksjon forventer og returnerer.
- **Feilsøking:** IDE-er og verktøy som `mypy` kan oppdage typefeil før kjøring.
- **Dokumentasjon:** Type-hints fungerer som innebygd dokumentasjon.
- **Samarbeid:** Gjør det enklere for andre utviklere å forstå og bruke koden.

**Husk:** Type-hints er valgfrie i Python og påvirker ikke kjøringen av programmet — de er et hjelpemiddel for utviklere og verktøy.
