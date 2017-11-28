; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

INCLUDE Irvine32.inc

.data
dealtCards DWORD 51 DUP(?)
cardsDealt = 0
playerHand DWORD 10 DUP(?)
cardsInPlayerHand = 0

.code
dealCardToPlayer proc
	mov eax, 53 ;set values to be randomized between 0-52
	call RandomRange
	mov [dealtCards + cardsDealt], eax
	
	mov [playerHand + cardsInPlayerHand], eax
	
	ret
dealCardToPlayer endp

main proc
	call Randomize ;seed RNG for program			

	exit
main endp
end main