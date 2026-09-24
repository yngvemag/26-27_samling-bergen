# Spesielle Metoder i Python

Spesielle metoder i Python er omringet av doble understreker (`__`) og gir spesielle funksjonaliteter til klassene. Her er noen vanlige spesielle metoder:

| Metode           | Beskrivelse |
|------------------|-------------|
| `__init__(self, ...) ` | Konstruktørmetoden som kalles når en ny instans av klassen blir opprettet. Brukes til å initialisere attributter i klassen. |
| `__str__(self)`      | Returnerer en lesbar strengrepresentasjon av et objekt. Ofte brukt for å definere hvordan objektet skal vises når det printes. |
| `__repr__(self)`     | Returnerer en offisiell strengrepresentasjon av et objekt. Brukes for en klar beskrivelse som ofte kan brukes til å gjenskape objektet. |
| `__del__(self)`      | Destruktørmetode som kalles når et objekt blir ødelagt (slettet). Kan brukes for opprydning. |
| `__eq__(self, other)`| Definerer oppførsel for likhetsoperatoren `==`. |
| `__ne__(self, other)`| Definerer oppførsel for ulikhetsoperatoren `!=`. |
| `__lt__(self, other)`| Definerer oppførsel for mindre-enn-operatoren `<`. |
| `__gt__(self, other)`| Definerer oppførsel for større-enn-operatoren `>`. |
| `__le__(self, other)`| Definerer oppførsel for mindre-enn-eller-lik-operatoren `<=`. |
| `__ge__(self, other)`| Definerer oppførsel for større-enn-eller-lik-operatoren `>=`. |
| `__add__(self, other)`| Definerer oppførsel for addisjonsoperatoren `+`. |
| `__sub__(self, other)`| Definerer oppførsel for subtraksjonsoperatoren `-`. |
| `__mul__(self, other)`| Definerer oppførsel for multiplikasjonsoperatoren `*`. |
| `__truediv__(self, other)`| Definerer oppførsel for divisjonsoperatoren `/`. |
| `__len__(self)`      | Returnerer lengden av objektet. Brukes ofte i samlinger. |

Disse metodene er en del av Python sin "magi" og tillater utviklere å definere hvordan objekter oppfører seg i forskjellige sammenhenger. 
