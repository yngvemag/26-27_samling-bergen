
# print odd numbers 1-20
for i in range(1, 21, 2):
    print(i, end="\t")


name = "Yngve Magnussen"
for c in name:
    print(c, end=" ")

"""
*
**
***
****
*****
******
*******
********
*********
**********
"""
char = ""
for i in range(10):
    char += "*"
    print(char)

"""
**********
*********
********
*******
******
*****
****
***
**
*
"""
for linjenr in range(1, 11): # Kontrollere linjer !!

    # hva skal skje på hver linje
    # starte med 10 stjerner og trekke fra 1 for hver gang vi har ny linje
    # skrive ut riktig antall stjerner
    # riktig antall stjerner:
    #   11 - 1 (første gang) 10  1 -> linjenr
    #   11 - 2 (andre gang)   9  2 -> linjenr
    #   11 - 3 (tredje gang)  8  3 -> linjenr
    for j in range(11 - linjenr):
        print("*", end="")
        
    print() # tvinge ny linje - må ligge i løkken for linje kontroll