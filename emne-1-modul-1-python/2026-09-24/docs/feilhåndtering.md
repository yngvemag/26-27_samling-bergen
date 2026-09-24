# Feilhåndtering i Python

Feilhåndtering handler om å håndtere feil som oppstår mens programmet kjører, slik at det ikke krasjer.

**I Python kalles feil som oppstår under kjøring for unntak (exceptions).**

Uten feilhåndtering vil et program stoppe helt når det møter en feil. Med feilhåndtering kan vi reagere på feilen og la programmet fortsette.

---

# 1. Hva er et unntak?

Et unntak er en feil som oppstår mens programmet kjører.

```python
number = int("abc")
```

**Utskrift:**

```text
ValueError: invalid literal for int() with base 10: 'abc'
```

Python stopper programmet og viser en feilmelding. Dette kalles at et unntak blir *kastet* (raised).

## Vanlige innebygde unntak

| Unntak | Når oppstår det? |
|---|---|
| `ValueError` | Ugyldig verdi, f.eks. `int("abc")`. |
| `TypeError` | Feil datatype, f.eks. `"hello" + 5`. |
| `ZeroDivisionError` | Divisjon med null, f.eks. `10 / 0`. |
| `IndexError` | Ugyldig indeks i liste, f.eks. `items[99]`. |
| `KeyError` | Nøkkelen finnes ikke i en ordbok, f.eks. `d["x"]`. |
| `FileNotFoundError` | Filen finnes ikke. |
| `PermissionError` | Mangler tilgang til ressursen. |
| `AttributeError` | Attributt eller metode finnes ikke på objektet. |
| `NameError` | Variabelen er ikke definert. |
| `OSError` | Generell systemfeil (fil, nettverk, osv.). |

---

# 2. `try` og `except`

Vi bruker `try`/`except` for å fange opp unntak og reagere på dem.

## Syntaks

```python
try:
    # Code that might fail
except ExceptionType:
    # Code that runs if the error occurs
```

## Eksempel

```python
try:
    number = int("abc")
except ValueError:
    print("That is not a valid number!")
```

**Utskrift:**

```text
That is not a valid number!
```

Programmet krasjer ikke — i stedet kjøres `except`-blokken.

---

# 3. Fange opp feilmeldingen

Vi kan hente selve feilmeldingen med `as`:

```python
try:
    number = int("abc")
except ValueError as error:
    print(f"Error: {error}")
```

**Utskrift:**

```text
Error: invalid literal for int() with base 10: 'abc'
```

---

# 4. Flere `except`-blokker

Vi kan håndtere forskjellige unntak ulikt ved å legge til flere `except`-blokker.

```python
def divide(a: int, b: int) -> float:
    try:
        return a / b
    except ZeroDivisionError:
        print("Cannot divide by zero!")
        return 0.0
    except TypeError as error:
        print(f"Wrong type: {error}")
        return 0.0
```

**Eksempel på bruk:**

```python
print(divide(10, 2))
print(divide(10, 0))
print(divide(10, "a"))
```

**Utskrift:**

```text
5.0
Cannot divide by zero!
0.0
Wrong type: unsupported operand type(s) for /: 'int' and 'str'
0.0
```

**Husk:** Legg alltid de mest spesifikke unntakene øverst og de mest generelle nederst.

---

# 5. `else` – kjør hvis ingen feil oppstod

`else`-blokken kjøres bare hvis `try`-blokken fullførte uten feil.

```python
try:
    number = int("42")
except ValueError:
    print("Invalid number")
else:
    print(f"Converted number: {number}")
```

**Utskrift:**

```text
Converted number: 42
```

Dette er nyttig for å skille mellom «koden som kan feile» og «koden som avhenger av at det gikk bra».

---

# 6. `finally` – kjør alltid

`finally`-blokken kjøres alltid, uansett om det oppstod en feil eller ikke.

```python
try:
    file = open('data.txt', 'r', encoding='utf-8')
    content = file.read()
except FileNotFoundError:
    print("File not found")
finally:
    print("This always runs")
```

**Utskrift (hvis filen ikke finnes):**

```text
File not found
This always runs
```

`finally` brukes typisk til opprydding — som å lukke filer eller databasetilkoblinger — men `with`-blokken gjør dette automatisk for filer.

---

# 7. Kombinere `try`, `except`, `else` og `finally`

Alle fire kan brukes sammen.

```python
def parse_number(text: str) -> int | None:
    try:
        number = int(text)
    except ValueError:
        print(f"'{text}' is not a valid integer")
        return None
    else:
        print(f"Conversion successful: {number}")
        return number
    finally:
        print("Done with conversion")
```

**Eksempel på bruk:**

```python
parse_number("10")
print("---")
parse_number("abc")
```

**Utskrift:**

```text
Conversion successful: 10
Done with conversion
---
'abc' is not a valid integer
Done with conversion
```

---

# 8. Kaste egne unntak: `raise`

Vi kan kaste unntak selv med `raise`. Dette er nyttig for å validere input.

```python
def set_age(age: int) -> None:
    if age < 0:
        raise ValueError(f"Age cannot be negative: {age}")
    print(f"Age set to: {age}")
```

**Eksempel på bruk:**

```python
set_age(25)
set_age(-5)
```

**Utskrift:**

```text
Age set to: 25
ValueError: Age cannot be negative: -5
```

Vi kan fange opp dette unntaket utenfor funksjonen:

```python
try:
    set_age(-5)
except ValueError as error:
    print(f"Invalid value: {error}")
```

**Utskrift:**

```text
Invalid value: Age cannot be negative: -5
```

---

# 9. Egendefinerte unntak

Vi kan lage våre egne unntak ved å lage en klasse som arver fra `Exception`.

```python
class InvalidAgeError(Exception):
    pass


class InvalidNameError(Exception):
    pass
```

## Bruk av egendefinerte unntak

```python
def create_user(name: str, age: int) -> None:
    if not name:
        raise InvalidNameError("Name cannot be empty")
    if age < 0 or age > 150:
        raise InvalidAgeError(f"Invalid age: {age}")
    print(f"User created: {name}, {age} years old")


try:
    create_user("Alice", 200)
except InvalidAgeError as error:
    print(f"Age error: {error}")
except InvalidNameError as error:
    print(f"Name error: {error}")
```

**Utskrift:**

```text
Age error: Invalid age: 200
```

Egendefinerte unntak gjør koden mer lesbar og lar oss skille mellom ulike typer feil.

---

# 10. Komplett eksempel: Konverter og valider brukerdata

Vi lager en funksjon som leser en liste med strenger, konverterer dem til tall, og håndterer alle feil underveis.

```python
def convert_to_numbers(values: list[str]) -> list[int]:
    results: list[int] = []

    for idx, value in enumerate(values, start=1):
        try:
            number = int(value)

            if number < 0:
                raise ValueError(f"Negative numbers not allowed: {number}")

            results.append(number)

        except ValueError as error:
            print(f"Skipping element {idx} ('{value}'): {error}")

    return results


if __name__ == '__main__':
    input_data = ["10", "abc", "25", "-3", "7", ""]

    number_list = convert_to_numbers(input_data)

    print(f"\nValid numbers: {number_list}")
    print(f"Sum: {sum(number_list)}")
```

**Utskrift:**

```text
Skipping element 2 ('abc'): invalid literal for int() with base 10: 'abc'
Skipping element 4 ('-3'): Negative numbers not allowed: -3
Skipping element 6 (''): invalid literal for int() with base 10: ''

Valid numbers: [10, 25, 7]
Sum: 42
```

---

# Oppsummering

| Nøkkelord | Beskrivelse |
|---|---|
| `try` | Kode som kan feile. |
| `except ExceptionType` | Håndterer et spesifikt unntak. |
| `except ExceptionType as e` | Håndterer unntak og henter feilmeldingen. |
| `else` | Kjøres hvis `try`-blokken fullførte uten feil. |
| `finally` | Kjøres alltid, uansett om det oppstod feil. |
| `raise` | Kaster et unntak manuelt. |
| Egendefinert unntak | En klasse som arver fra `Exception`. |

## Gode vaner

- **Vær spesifikk:** Fang alltid det mest spesifikke unntaket du kan, ikke bare `except Exception`.
- **Gi tydelige meldinger:** Feilmeldingen bør si hva som gikk galt og gjerne hvilken verdi som forårsaket feilen.
- **Ikke skjul feil:** En tom `except`-blokk uten innhold gjør feilsøking svært vanskelig.
- **Bruk `raise` for validering:** Kast unntak tidlig hvis input er ugyldig, i stedet for å la feilen spre seg.

**Husk:** Feilhåndtering gjør programmet robust — det skal kunne møte uventede situasjoner og gi brukeren en forståelig tilbakemelding, ikke krasje med en kryptisk feilmelding.
