;BlackJack project
;Nicholas Little and Steven Schierman

INCLUDE Irvine32.inc

.data
;player hand values
playerHand BYTE 14 DUP(?)
cardsInPlayerHand BYTE 0
sumOfPlayerHand DWORD 0
stayValue BYTE 0
playerHighAce BYTE 0
playerBust DWORD 0
player21 DWORD 0
playerHandIndicator BYTE "------Your Hand-----", 0ah, "sum:", 0h

;dealer hand values
dealerHand BYTE 14 DUP(?), 1
cardsInDealerHand BYTE 0
sumOfDealerHand DWORD 0
dealerHighAce BYTE 0
dealerBust DWORD 0
dealer21 DWORD 0
dealerHandIndicator BYTE "------Dealer's Hand------", 0ah, 0h
sumText BYTE "sum:", 0h

;End Conditions
winMessage BYTE 0ah, "YOU WIN!!", 0ah, 0h
loseMessage BYTE 0ah, "YOU LOST....", 0ah, "Better luck next time.", 0ah, 0h
tieMessage BYTE 0ah, "THERE IS A PUSH.", 0ah, 0h

;User input values
whatToDo BYTE "Would you like to hit or stay?", 0ah, "Type 'hit' or 'stay' then press enter to submit.", 0ah, 0h
input BYTE 5 DUP(?)
newGame BYTE "Would you like to play again?", 0ah, "Type 'yes' to continue or 'no' to end.", 0ah, 0h



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
	mov edx, OFFSET playerHandIndicator
	call WriteString ;Title hand
	mov eax, sumOfPlayerHand
	call WriteInt
	call CrLf
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
	mov edx, OFFSET dealerHandIndicator
	call WriteString ;Title hand
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
	mov eax, 13 ;get range for RandomRange 
	call RandomRange
	add eax, 2 ;get range 2-14
	movzx ebx, cardsInPlayerHand ;counter for cards in hand
	mov [playerHand + ebx], al ;create new value in next empty space in playerHand
	inc ebx
	mov cardsInPlayerHand, bl ;update card counter

	cmp eax, 14 ;compare to ace card
	je aceDealt

	cmp eax, 10 ;compare to determine if facecard
	jg faceCard

	;numbered cards
	mov ebx, sumOfPlayerHand ;copy sum to ebx
	add eax, ebx ;add new card to sum
	mov sumOfPlayerHand, eax ;move new sum to memory
	jmp checkBust

	faceCard:
		mov ebx, sumOfPlayerHand
		add ebx, 10
		mov sumOfPlayerHand, ebx
		jmp checkBust

	aceDealt:
		cmp sumOfPlayerHand, 10 ;determine if high ace or low ace needed
		jg lowAce
		mov ebx, sumOfPlayerHand
		add ebx, 11 ;high ace value
		mov sumOfPlayerHand, ebx
		mov playerHighAce, 1 ;store that hend has a high ace
		jmp checkBust

		lowAce:
			mov ebx, sumOfPlayerHand
			add ebx, 1
			mov sumOfPlayerHand, ebx
			jmp checkBust

	checkBust:
		;check if hand sums to 21
		mov eax, player21 
		mov ebx, 1
		cmp sumOfPlayerHand, 21 ;find if hand is equal to 21
		cmove eax, ebx 
		mov player21, eax ;sets player21 to 1 of sum = 21

		;check if hand is greater than 21
		mov eax, playerBust
		mov ebx, 1
		cmp sumOfPlayerHand, 21 ;find if hand is greater than 21
		cmova eax, ebx 
		cmp eax, 1
		jne continue ;hand is less than 21
		cmp playerHighAce, 1 ;hand has a high ace in it
		jne bust ;over 21 and no high ace
		mov playerHighAce, 0 ;reset high ace counter
		mov eax, sumOfPlayerHand
		sub eax, 10 ;make low ace
		mov sumOfPlayerHand, eax
		jmp checkBust ;check if low ace sum is still a bust

		bust:
			mov playerBust, 1 ;set bust counter
			ret
		continue:
			ret

addCardPlayer endp

addCardDealer proc
	mov eax, 0
	mov ebx, 0
	mov eax, 12 ;get range for RandomRange 
	call RandomRange
	add eax, 2 ;get range 2-14
	movzx ebx, cardsInDealerHand ;counter for cards in hand
	mov [dealerHand + ebx], al ;create new value in next empty space in dealer hand
	inc ebx
	mov cardsInDealerHand, bl ;update card counter

	cmp eax, 14 ;compare to ace card
	je aceDealt

	cmp eax, 10 ;compare to determine if facecard
	jg faceCard

	;numbered cards
	mov ebx, sumOfDealerHand ;copy sum to ebx
	add eax, ebx ;add new card to sum
	mov sumOfDealerHand, eax ;move new sum to memory
	jmp checkBust

	faceCard:
		mov ebx, sumOfDealerHand
		add ebx, 10
		mov sumOfDealerHand, ebx
		jmp checkBust

	aceDealt:
		cmp sumOfDealerHand, 10 ;determine if high ace or low ace needed
		jg lowAce
		mov ebx, sumOfDealerHand
		add ebx, 11 ;high ace value
		mov sumOfDealerHand, ebx
		mov dealerHighAce, 1
		jmp checkBust

		lowAce:
			mov ebx, sumOfDealerHand
			add ebx, 1
			mov sumOfDealerHand, ebx
			jmp checkBust

		checkBust:
		;check if hand sums to 21
		mov eax, dealer21 
		mov ebx, 1
		cmp sumOfDealerHand, 21 ;find if hand is equal to 21
		cmove eax, ebx
		mov dealer21, eax ;set 21 counter if hand = 21

		;check if hand is greater than 21
		mov eax, dealerBust
		mov ebx, 1
		cmp sumOfDealerHand, 21 ;compare sum of hand and 21
		cmova eax, ebx ;set eax to one if hand > 21
		cmp eax, 1  
		jne continue ;contuine if not > 21
		cmp dealerHighAce, 1 ;look for ace in hand
		jne bust ;hand > 21 and no high ace
		mov dealerHighAce, 0 ;reset high ace counter
		mov eax, sumOfDealerHand 
		sub eax, 10 ;make high ace, low ace
		mov sumOfDealerHand, eax
		jmp checkBust; check new value for bust

		bust:
			mov dealerBust, 1
			ret
		continue:
			ret
		
		ret
addCardDealer endp

dealing proc
	call addCardDealer ;deal one card to dealer
	call addCardDealer ;deal one card to dealer
	call displayDealerHand ;display dealer hand
	call addCardPlayer ;deal one card to player
	call addCardPlayer ;deal one card to player
	call displayPlayerHand ;show player their hand
	ret
dealing endp

getUserInput proc 
	mov edx, OFFSET whatToDo ;display instructions for player
	call WriteString
	mov edx, OFFSET input ;load buffer parameter
	mov ecx, SIZEOF input ;load max character parameter
	call ReadString ; call Irvine procedure user input stored in 'input'

	cmp eax, 3 ;eax contains length of input string compare with 3(hit)
	je hit

	;stay
	mov stayValue, 1 ;set stay counter so player hand is locked in
	ret

	hit:;hit
		call addCardPlayer ;player hits so give them card and display hand
		call displayPlayerHand
		ret
	
getUserInput endp

endDisplay proc
	mov al, dealerHand
	mov [dealerHand + 14], al ;"flips" upsidedown card
	call displayDealerHand ;display dealer final hand
	mov edx, OFFSET sumText 
	call WriteString
	mov eax, sumOfDealerHand ;display a sum of dealers hand
	call WriteInt
	call CrLf
	call displayPlayerHand ;display player final hand
	ret
endDisplay endp

resetValues proc
	;reset values of player hand to 0
	mov ecx, 14 ;number of values in player hand
	L1: ;resets all values of playerHand to 0
		mov [playerHand + ecx], 0
	loop L1
	mov playerHand, 0
	mov sumOfPlayerHand, 0
	mov cardsInPlayerHand, 0
	mov stayValue, 0
	mov playerBust, 0
	mov player21, 0
	mov playerHighAce, 0

	;reset all values of dealer hand
	mov [dealerHand + 14], 1
	mov ecx, 13 ;skip up side down card
	L2:
		mov [dealerHand+ecx], 0
	loop L2
	mov dealerHand, 0
	mov sumOfDealerHand, 0
	mov cardsInDealerHand, 0
	mov dealerBust, 0
	mov dealer21, 0
	mov dealerHighAce, 0

	ret
resetValues endp

main proc
	begin: ;loop for new hand
	call resetValues ;resets all game values

	call Randomize ;seed RNG for program
	call dealing ;deal and display 2 cards to player and dealer "dummy card" for dealer displayed upside down
	
	playerRound: ;loop while player has control
		cmp player21, 1 ;check if player has 21
		je Win
		cmp dealer21, 1 ;check if dealer has 21
		je Lose
		call getUserInput ;allow player to hit or stay
		cmp stayValue, 1 ;comapre if player stays
		je dealerRound ; if player stays dealer goes
		cmp playerBust, 1 ;if player busts player loses
		je Lose
	jmp playerRound


	dealerRound: ;loop while dealer has control
		cmp dealer21, 1
		je Lose
		cmp dealerBust, 1
		je Win
		mov eax, sumOfDealerHand
		cmp eax, sumOfPlayerHand
		je Tie ;dealerHand = playerHand
		jg Lose ;dealerHand > playerHand
		;dealerHand < playerHand
		call addCardDealer
		call displayDealerHand
		jmp dealerRound
		

	Win:
		mov edx, OFFSET winMessage
		call WriteString
		call endDisplay
		jmp endL
	Lose:
		mov edx, OFFSET loseMessage
		call WriteString
		call endDisplay
		jmp endL
	Tie:
		mov edx, OFFSET tieMessage
		call WriteString
		call endDisplay
	endL:
		mov edx, OFFSET newGame ;display instructions for player
		call WriteString
		mov edx, OFFSET input ;load buffer parameter
		mov ecx, SIZEOF input ;load max character parameter
		call ReadString ; call Irvine procedure user input stored in 'input'
		cmp eax, 3
		je begin
	exit
main endp
end main