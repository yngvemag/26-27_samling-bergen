
# Lese inn to tall
#   - sørge for at dette er to tall og ikke noe annet
#   - gi feilmelding

# break -> hopp ut av løkken nå !!
# continue -> hopp over resten av koden i løkken og start på ny runde
while True: # YTRE LØKKE - spill kontroll, når av slutter vi
    # Les inn tall på trygg måte !
    while True:  # MÅ HA STOPP !!!
        number_a_str = input("Skriv inn et tall 1: ")
        if not number_a_str.isdigit():
            print("Du må skrive inn et gyldig tall, prøv igjen.")
            continue

        number_b_str = input("Skriv inn et tall 2: ")
        if not number_b_str.isdigit():
            print("Du må skrive inn et gyldig tall, prøv igjen")
            continue

        break # KJEMPE VIKTIG !! Hoppe ut av løkken

    # caste innlest tall til ekte tall (int)
    # når vi har lest 2 tall - cast til int (heltall) og gjør multiplikasjon
    number_a = int(number_a_str)
    number_b = int(number_b_str)

    print(f"{number_a} * {number_b} = {number_a*number_b}")

    exit_game = input("For å avslutte tast '0'") # input gir ALLTID string
    if exit_game == "0":
        print("Takk for at du spilte :-)")
        break