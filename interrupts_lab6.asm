.data
.globl cflag 		#δηλώνω cflag,cdata ως global για να μπορεί να τα διαχειριστεί ο interupt handler
.globl cdata

menu: .asciiz "Menu:\n1)Submenu1\n2)Submenu2\n3)Exit\n\n"
submenu1: .asciiz "Submenu1\n"
submenu2: .asciiz "Submenu2\n"
exit: .asciiz "Exit\n"
cflag: .space 4
cdata: .space 4
newline: .asciiz "\n"

.text
.globl main

main:

li $v0, 4 	
la $a0, menu #μενού
syscall


mfc0 $t0,$12 	#διαβάζω τον status register
andi $t0,$t0,1 	#παίρνω το lsb 
mtc0 $t0,$12 	#φορτώνω το lsb στον status register

lw  $t0,0xffff0000 	#διαβάζω απ'τον receiver control
srl $t0, $t0, 8 	#ολισθαίνω κατά 8bits=1bytes για να πάρω το 2ο lsb
andi $t0,$t0,1  	#παίρνω το 2ο lsb
sw $t0,0xffff0000	


li $t1, 0
la $v0, cflag	#παίρνω την διεύθυνση του cflag
sw $t1, 0($v0)	#βάζω 0 στο cflag