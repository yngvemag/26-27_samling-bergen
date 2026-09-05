# Introduksjon til Turtle i Python

`turtle` er et innebygd Python-bibliotek der du styrer en liten "skilpadde"
som tegner i et eget vindu. Det er en nyttig måte å øve på sekvenser,
variabler, løkker og funksjoner på: Hver instruksjon du skriver, blir synlig
som en bevegelse eller en tegning.

## Kom i gang

Importer biblioteket og avslutt programmet med enten `turtle.done()` eller
`turtle.exitonclick()`. Begge holder tegnevinduet åpent etter at tegningen er
ferdig.

```python
import turtle

turtle.exitonclick()
```

Skriv koden i en fil, for eksempel `tegning.py`, og kjør filen. Et tomt
tegne-vindu åpner seg.

`turtle.done()` lar deg lukke vinduet på vanlig måte. `turtle.exitonclick()`
lukker vinduet når du klikker inne i det. Bruk én av dem, helt nederst i
programmet.

## Bevege seg og snu

Turtle starter midt i vinduet og peker mot høyre. Når pennen er nede, tegner
den en linje mens den beveger seg.

```python
import turtle

turtle.forward(100)  # Gå 100 piksler fremover.
turtle.left(90)      # Snu 90 grader mot venstre.
turtle.forward(100)

turtle.done()
```

De viktigste kommandoene er:

| Kommando | Hva den gjør |
| --- | --- |
| `turtle.forward(antall)` | Beveger skilpadden fremover. |
| `turtle.backward(antall)` | Beveger skilpadden bakover. |
| `turtle.left(vinkel)` | Snur mot venstre med angitt antall grader. |
| `turtle.right(vinkel)` | Snur mot høyre med angitt antall grader. |

Dette programmet tegner et kvadrat:

```python
import turtle

for _ in range(4):
    turtle.forward(100)
    turtle.left(90)

turtle.done()
```

Løkken gjentar de samme to instruksjonene fire ganger. Det sparer deg for
gjentatt kode.

## Løfte og sette ned pennen

Bruk `penup()` når skilpadden skal flytte seg uten å tegne. Bruk `pendown()`
når den skal begynne å tegne igjen.

```python
import turtle

turtle.forward(100)
turtle.penup()
turtle.forward(50)   # Ingen linje i dette stykket.
turtle.pendown()
turtle.forward(100)

turtle.done()
```

Dette er spesielt nyttig når du vil plassere flere figurer ulike steder i
vinduet.

## Velge farger

`pencolor()` setter fargen på streken. `fillcolor()` velger fargen som brukes
inne i en figur. For å fylle en figur bruker du `begin_fill()` før du tegner
den og `end_fill()` etterpå.

```python
import turtle

turtle.pencolor("navy")
turtle.fillcolor("skyblue")

turtle.begin_fill()
for _ in range(4):
    turtle.forward(120)
    turtle.left(90)
turtle.end_fill()

turtle.done()
```

Du kan bruke vanlige fargenavn, som `"red"`, `"green"` og `"purple"`. Du kan
også angi strek- og fyllfarge samtidig:

```python
turtle.color("darkgreen", "lightgreen")
```

Den første fargen er strekfargen, og den andre er fyllfargen.

## Flytte til et bestemt punkt med `goto`

`goto(x, y)` flytter skilpadden til en bestemt posisjon. Midten av vinduet er
`(0, 0)`. Positive `x`-verdier går mot høyre, negative `x`-verdier går mot
venstre. Positive `y`-verdier går opp, og negative `y`-verdier går ned.

```python
import turtle

turtle.penup()
turtle.goto(-150, 100)
turtle.pendown()

for _ in range(3):
    turtle.forward(100)
    turtle.left(120)

turtle.done()
```

Her flytter skilpadden seg først til `(-150, 100)` uten å tegne, før den
tegner en trekant.

## Tegne sirkler

`circle(radius)` tegner en sirkel. Radius bestemmer størrelsen.

```python
import turtle

turtle.circle(80)

turtle.done()
```

Du kan også tegne en del av en sirkel ved å oppgi en vinkel:

```python
turtle.circle(80, 180)  # Tegner en halvsirkel.
```

## Et samlet eksempel

Programmet under tegner en enkel blomst. Det bruker løkke, farger, sirkler og
`goto()`.

```python
import turtle

turtle.speed(0)
turtle.pencolor("darkred")
turtle.fillcolor("pink")

for _ in range(8):
    turtle.begin_fill()
    turtle.circle(60)
    turtle.end_fill()
    turtle.left(45)

turtle.penup()
turtle.goto(0, -20)
turtle.pendown()
turtle.color("darkorange", "gold")
turtle.begin_fill()
turtle.circle(25)
turtle.end_fill()

turtle.done()
```

`speed(0)` gjør at Turtle tegner så raskt som mulig. Prøv å endre antall
gjentakelser, sirkelradiusene eller fargene, og se hvordan tegningen endrer
seg.


