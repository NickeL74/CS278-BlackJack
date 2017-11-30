; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

INCLUDE Irvine32.inc

.data
;player hand values
playerHand BYTE 14 DUP(?)
cardsInPlayerHand BYTE 0
playerHandIndicator BYTE "------Your Hand-----", 0ah, 0h

;dealer hand values
dealerHand BYTE 14 DUP(?), 1
cardsInDealerHand BYTE 0
dealerHandIndicator BYTE "------Dealer's Hand------", 0ah, 0h

;User input values
whatToDo BYTE "Would you like to hit or stay?", 0ah, "Type 'hit' or 'stay' then press enter to submit.", 0ah, 0h
input BYTE 5 DUP(?)
hitTest BYTE "hit"


;Cards displayed
Back BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Ace BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|A.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........A|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Two BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|2.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........2|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Three BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|3.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........3|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Four BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|4.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........4|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Five BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|5.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........5|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Six  BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|6.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........6|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Seven BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|7.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........7|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Eight BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|8.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........8|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Nine BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|9.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........9|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Ten BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|10........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|........10|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Jack BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|J.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........J|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
Queen BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|Q.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........Q|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h
King BYTE 0dah, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0bfh, 0ah,
"|K.........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|..........|", 0ah,
"|.........K|", 0ah,
0c0h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0c4h, 0d9h, 0ah, 0h


.code
displayPlayerHand proc
	mov ecx, LENGTHOF playerHand ;set loop number for number of cards in hand
	dec ecx ;decrease ecx bacause array starts with 0 not 1
	L1: ;loop through all cards
		mov al, [playerHand + ecx] ;move current card value to al for comparison

		;compare al to all possible values and jump to corrasponding section
		cmp al, 0 ;compare if memory location doesn't hold a card
		je emptyCard
		cmp al, 2
		je cardTwo
		cmp al, 3
		je cardThree
		cmp al, 4
		je cardFour
		cmp al, 5
		je cardFive
		cmp al, 6
		je cardSix
		cmp al, 7
		je cardSeven
		cmp al, 8
		je cardEight
		cmp al, 9
		je cardNine
		cmp al, 10
		je cardTen
		cmp al, 11
		je cardJack
		cmp al, 12
		je cardQueen
		cmp al, 13
		je cardKing
		cmp al, 14
		je cardAce

		;move offset of correct value to edx.
		;Call Irvine WriteString
		;decrament edx and if edx greater than or equal zero jump to top for next card
		;if edx is less than zero jump to Return
		emptyCard:
			dec ecx
			cmp ecx, 0
			jge L1
			jng Return
		cardTwo:
			mov edx, OFFSET Two
			call WriteString
			dec ecx
			cmp ecx, 0
			jge L1
			jng Return
		cardThree:
			mov edx, OFFSET Three
			call WriteString
			dec ecx
			cmp ecx, 0
			jge L1
			jng Return
		cardFour:
			mov edx, OFFSET Four
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
		cardFive:
			mov edx, OFFSET Five
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
		cardSix:
			mov edx, OFFSET Six
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
		cardSeven:
			mov edx, OFFSET Seven
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
		cardEight:
			mov edx, OFFSET Eight
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
		cardNine:
			mov edx, OFFSET Nine
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
		cardTen:
			mov edx, OFFSET Ten
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
		cardJack:
			mov edx, OFFSET Jack
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
		cardQueen:
			mov edx, OFFSET Queen
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
		cardKing:
			mov edx, OFFSET King
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
		cardAce:
			mov edx, OFFSET Ace
			call WriteString
			dec ecx 
			cmp ecx, 0
			jge L1
			jng Return
	Return:	;end of drawing all cards in hand
		call CRLF
		ret
displayPlayerHand endp

displayDealerHand proc
	mov ecx, LENGTHOF dealerHand ;set loop number for number of cards in hand
	dec ecx ;decrease ecx bacause array starts with 0 not 1
	L1: ;loop through all cards
		mov al, [dealerHand + ecx] ;move current card value to al for comparison

		;compare al to all possible values and jump to corrasponding section
		cmp al, 0 ;compare if memory location doesn't hold a card
		je emptyCard
		cmp al, 1
		je backCard
		cmp al, 2
		je cardTwo
		cmp al, 3
		je cardThree
		cmp al, 4
		je cardFour
		cmp al, 5
		je cardFive
		cmp al, 6
		je cardSix
		cmp al, 7
		je cardSeven
		cmp al, 8
		je cardEight
		cmp al, 9
		je cardNine
		cmp al, 10
		je cardTen
		cmp al, 11
		je cardJack
		cmp al, 12
		je cardQueen
		cmp al, 13
		je cardKing
		cmp al, 14
		je cardAce

		;move offset of correct value to edx.
		;Call Irvine WriteString
		;decrament edx and if edx greater than or equal zero jump to top for next card
		;if edx is less than zero jump to Return
		emptyCard:
			dec ecx
			cmp ecx, 1
			jge L1
			jng Return
		backCard:
			mov edx, OFFSET Back
			call WriteString
			dec ecx
			cmp ecx, 1
			jge L1
			jng Return
		cardTwo:
			mov edx, OFFSET Two
			call WriteString
			dec ecx
			cmp ecx, 1
			jge L1
			jng Return
		cardThree:
			mov edx, OFFSET Three
			call WriteString
			dec ecx
			cmp ecx, 1
			jge L1
			jng Return
		cardFour:
			mov edx, OFFSET Four
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
		cardFive:
			mov edx, OFFSET Five
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
		cardSix:
			mov edx, OFFSET Six
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
		cardSeven:
			mov edx, OFFSET Seven
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
		cardEight:
			mov edx, OFFSET Eight
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
		cardNine:
			mov edx, OFFSET Nine
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
		cardTen:
			mov edx, OFFSET Ten
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
		cardJack:
			mov edx, OFFSET Jack
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
		cardQueen:
			mov edx, OFFSET Queen
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
		cardKing:
			mov edx, OFFSET King
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
		cardAce:
			mov edx, OFFSET Ace
			call WriteString
			dec ecx 
			cmp ecx, 1
			jge L1
			jng Return
	Return:	;end of drawing all cards in hand
		call CRLF
		ret
displayDealerHand endp

addCardPlayer proc
	mov eax, 12 ;get range for RandomRange 
	call RandomRange
	add eax, 2 ;get range 2-14
	movzx ebx, cardsInPlayerHand ;counter for cards in hand
	mov [playerHand + ebx], al ;create new value in next empty space in playerHand
	inc ebx
	mov cardsInPlayerHand, bl ;update card counter 
	ret
addCardPlayer endp

addCardDealer proc
	mov eax, 12 ;get range for RandomRange 
	call RandomRange
	add eax, 2 ;get range 2-14
	movzx ebx, cardsInDealerHand ;counter for cards in hand
	mov [dealerHand + ebx], al ;create new value in next empty space in dealer hand
	inc ebx
	mov cardsInDealerHand, bl ;update card counter 
	ret
addCardDealer endp

dealing proc
	mov edx, OFFSET dealerHandIndicator
	call WriteString ;Title hand
	call addCardDealer ;deal one card to dealer
	call addCardDealer ;deal one card to dealer
	call displayDealerHand ;display dealer hand
	mov edx, OFFSET playerHandIndicator
	call WriteString ;Title hand
	call addCardPlayer ;deal one card to player
	call addCardPlayer ;deal one card to player
	call displayPlayerHand ;show player their hand
	ret
dealing endp

getUserInput proc ;NEEDS WORK
	mov edx, OFFSET whatToDo ;display instructions for player
	call WriteString
	mov edx, OFFSET input ;load buffer parameter
	mov ecx, SIZEOF input ;load max character parameter
	call ReadString ; call Irvine procedure user input stored in 'input'

	mov edx, OFFSET input
	mov ebx, OFFSET hitTest
	call Str_compare
	jnc stay
	mov eax, 4

	call addCardPlayer
	call displayPlayerHand

	stay:
		call addCardDealer
		call displayDealerHand
		ret



	
getUserInput endp
	

main proc
	call Randomize ;seed RNG for program
	call dealing ;deal and display 2 cards to player and dealer "dummy card" for dealer displayed upside down


	exit
main endp
end main