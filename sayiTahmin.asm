#make_COM#

; Yunus Ege Küçük
; 170421048
ORG 100h

JMP start
.data:
	var_info1 db "Her oyuncunun $",0
	var_info2 db " tahmin hakki olacak. $",0
	var_info3 db "Lutfen 1-100 arasinda bir sayi giriniz.$",0
	
	var_birinci db "1. oyuncu sayi giriniz: $",0
	var_birinci_win db "1. oyuncu kazandi. $",0
	var_ikinci db "2. oyuncu sayi giriniz: $",
	var_ikinci_win db "2. oyuncu kazandi. $",0
	
	var_newline db 13,10,'$'
	var_printrandom db "Oyun bitti.",13,10,"Rastgele Sayi: $",0
	var_yanlistahmin db "Her iki oyuncu da sayiyi yanlis tahmin etti.$",0
	var_dogrutahmin db "Her iki oyuncu da sayiyi dogru tahmin etti.$",0
	
	var_turn_msg1 db "Tur $",0
	var_turn_msg2 db ":$",0
	
	turn db 1 ; Kacinci turda oldugumuzun bilgisi
	counter db 5 ; Her oyuncunun tahmin hakki sayisi
	
.code:
include "emu8086.inc"
main proc
	start:
	; giris yazilari
	mov ah, 09h
	lea dx, var_info1
	int 21h
	mov ah, 02h
	mov dl, counter
	add dl, '0'
	int 21h
	mov ah, 09h
	lea dx, var_info2
	int 21h
	lea dx, var_info3
	int 21h

	; oyun
	call random
	mov cl, counter
	game:
		call newline
		call printturn
		call input1
		call newline
		call input2
		call newline
		call compare
		mov cx, 0
		mov cl, counter ; cx degistiginden dolayi yeniden atama
		dec counter
		inc turn
		loop game
	
	endgame:
		call newline
		lea dx, var_printrandom 
		mov ah, 09h
		int 21h ; stringi yazdir
		
		mov ax, 0
		mov al, [4F0h]
		call PRINT_NUM_UNS ; rastgele sayiyi yazdir
	
	hlt
	ret
main endp


random proc
	MOV AH, 00h
	INT 1AH      ; CX:DX'de sistem zamanini alacak sekilde interrupt
	mov  ax, dx
	xor  dx, dx
	mov  bx, 100
	div  bx       ; Bu satirdan sonra DX'de bolumden kalan sayimiz yani rastgele sayimiz oluyor. Bu sayi 0-99 arasinda
	mov si, dx
	add si, 1 ; rastgele sayiya 1 eklerek 1-100 arasinda yap
	mov es, si
	mov [4F0h], es ; sayiyi 4F0h adresine tasi
	ret
random endp


input1 proc
	lea dx, var_birinci
	mov ah,09h
	int 21h ; 1. oyuncu sayi giriniz yazdir
	call SCAN_NUM ; sayiyi al
	mov [4F1h], cx
	ret
input1 endp


input2 proc
	lea dx, var_ikinci
	mov ah,09h
	int 21h
	call SCAN_NUM
	mov [4F2h], cx
	ret
input2 endp


newline proc
	lea dx, var_newline
	mov ah, 09h
	int 21h
	ret
newline endp


; "Turn %d: \n" yazdirir
printturn proc
	lea dx, var_turn_msg1
	mov ah,09h
	int 21h
	mov dl, turn
	add dl, '0'
	mov ah, 02h
	int 21h
	lea dx, var_turn_msg2
	mov ah,09h
	int 21h
	call newline
	ret
printturn endp


compare proc
	mov AL, [4F1h] ; 1. oyuncunun sayisini al
	mov BL, [4F0h] ; Rastgele sayiyi al
	cmp AL,BL
	je if1
	mov AL, [4F2h] ; 2. oyuncunun sayisini al
	cmp AL, BL
	je if2
	jne else:
	
	if1:
		mov AL, [4F2h] ; 2. oyuncunun sayisini al
		cmp AL, BL
		je bothwon
		jne player1won
		
		bothwon:
			lea dx, var_dogrutahmin
			mov ah,09h
			int 21h
			jmp endgame

		player1won:
			lea dx, var_birinci_win
			mov ah,09h
			int 21h
			jmp endgame
	
	if2:
		lea dx, var_ikinci_win
		mov ah,09h
		int 21h
		jmp endgame
	
	else:
		lea dx, var_yanlistahmin
		mov ah,09h
		int 21h

	ret
compare endp


DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS