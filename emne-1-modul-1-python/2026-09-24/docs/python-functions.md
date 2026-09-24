| Funksjon     | Beskrivelse | Eksempel på bruk |
|--------------|-------------|------------------|
| **`max()`**  | Returnerer det største elementet i en sekvens eller blant flere argumenter. | `max([3, 5, 2])` -> `5` |
| **`min()`**  | Returnerer det minste elementet i en sekvens eller blant flere argumenter. | `min([3, 5, 2])` -> `2` |
| **`sum()`**  | Returnerer summen av elementene i en sekvens. | `sum([1, 2, 3])` -> `6` |
| **`len()`**  | Returnerer lengden (antall elementer) i en sekvens eller et objekt. | `len("Python")` -> `6` |
| **`zip()`**  | Kombinerer flere iterables (som lister eller tuples) til en iterator med tupler der hver tuple inneholder elementer fra hver iterable på samme indeks. | `list(zip([1, 2], ['a', 'b']))` -> `[(1, 'a'), (2, 'b')]` |
| **`reversed()`** | Returnerer en iterator som går gjennom elementene i en sekvens i reversert rekkefølge. | `list(reversed([1, 2, 3]))` -> `[3, 2, 1]` |
| **`sorted()`**  | Returnerer en sortert versjon av en sekvens uten å endre den opprinnelige. | `sorted([3, 1, 2])` -> `[1, 2, 3]` |
| **`filter()`**  | Returnerer en iterator med de elementene fra en sekvens som oppfyller et gitt betingelse (funksjon). | `list(filter(lambda x: x > 2, [1, 2, 3, 4]))` -> `[3, 4]` |
| **`map()`**  | Bruker en funksjon på hvert element i en sekvens og returnerer en iterator med resultatene. | `list(map(lambda x: x**2, [1, 2, 3]))` -> `[1, 4, 9]` |
