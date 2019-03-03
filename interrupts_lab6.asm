.data
.globl cflag 		#������ cflag,cdata �� global ��� �� ������ �� �� ������������ � interupt handler
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
la $a0, menu #�����
syscall


mfc0 $t0,$12 	#������� ��� status register
andi $t0,$t0,1 	#������ �� lsb 
mtc0 $t0,$12 	#������� �� lsb ���� status register

lw  $t0,0xffff0000 	#������� ��'��� receiver control
srl $t0, $t0, 8 	#��������� ���� 8bits=1bytes ��� �� ���� �� 2� lsb
andi $t0,$t0,1  	#������ �� 2� lsb
sw $t0,0xffff0000	


li $t1, 0
la $v0, cflag	#������ ��� ��������� ��� cflag
sw $t1, 0($v0)	#���� 0 ��� cflag