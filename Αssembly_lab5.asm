.data
.globl askint
.globl repint

Menu_Print: .asciiz "Printing the menu : "
Menu_Print1: .asciiz "1) Create a list"
Menu_Print2: .asciiz "2) Insert a node in the list!"
Menu_Print3: .asciiz "3) Delete the last node!"
Menu_Print4: .asciiz "4) Print node!"
Menu_Print5: .asciiz "5) Print the size of the list!"
Menu_Print6: .asciiz "6) Print the address of a node!"
Menu_Print7: .asciiz "7) Print the address of the list!"
Menu_Print8: .asciiz "8) Print value and value's address of the min value node!"
Menu_Print9: .asciiz "9) Sort List!"
Menu_Print10: .asciiz "10) Exit!"
CreateList:  .asciiz "A list is created!"
insert:      .asciiz "You insert a new node!"
delete:      .asciiz "Last node deleted!"
size:        .asciiz "The size of the list is: "
addr:        .asciiz "The address of the list is: " 
idprn:       .asciiz "ID: "
valprn:      .asciiz "VALUE: "
addrnode:    .asciiz "The address of the node is: "
minval:      .asciiz "The minimum value is: "
minvaladdr:  .asciiz "in address: "


memory:  .align 2
         .space 1200 #10 bytes the sum of memory of a node==>12 bytes per node==>1200 bytes for 100 nodes

askint: .asciiz "Give your selection: "
repint: .asciiz "The inserted value is : "
newline: .asciiz "\n"
id: .asciiz "Give ID: "
value: .asciiz "Give Value: "

.text
.globl main

main:



la $s1,memory #s1 is a pointer in 1200 space memory



#####################################################
#menu choices and newlines
#####################################################
restart:
li $v0, 4			 
la $a0, Menu_Print 
syscall	

li $v0, 4
la $a0, newline
syscall

li $v0, 4		 
la $a0, Menu_Print1
syscall	

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print2
syscall	

li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print3
syscall	

li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print4
syscall	

li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print5
syscall	

li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print6
syscall	

li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print7
syscall	

li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print8
syscall	

li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print9
syscall	

li $v0, 4
la $a0, newline
syscall


li $v0, 4
la $a0, Menu_Print10
syscall	

li $v0, 4
la $a0, newline
syscall

################################################################
#USER'S MENU CHOICE
################################################################
#Print askint
li $v0, 4
la $a0, askint
syscall
		
#Read the choice
li $v0,5
syscall
move $t0, $v0

#print repint
li $v0, 4
la $a0, repint
syscall

#print the choice
li $v0, 1
move $a0, $t0 
syscall

#newline
li $v0, 4
la $a0, newline
syscall


#########################################
bge $t0,10,restart          #while loop
ble $t0,0,restart	     
#########################################
#######################################
#if cases
#-CHOICE 1:
#######################################
bne $t0,1,else_label
li $v0, 4
la $a0, newline
syscall

li $v0, 4			 
la $a0, Menu_Print1
syscall	

li $v0, 4
la $a0, newline
syscall

#####read the id in register $v0 and move it in $a1 to pass it in createList function
li $v0, 4			 
la $a0, id
syscall


li $v0, 5
syscall
move $a1, $v0 #a1 = id  


#####read the value in register $v0 and move it in $a0 to pass it in createList function
#read value
li $v0, 4			 
la $a0, value
syscall

li $v0, 5
syscall
move $a0, $v0 #a0 = value 


#####move the head of the list in register $a2

move $a2, $s1  # $a2=head 

jal createList

move $s2,$v0
li $s3,1 #size of the list

li $v0,4
la $a0, newline
syscall

li $v0,4
la $a0, newline
syscall

j end_label

######################################
#-CHOICE 2
#####################################

else_label:
bne $t0,2,else_label2
li $v0, 4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print2
syscall

li $v0,4
la $a0, newline
syscall


#####read the id in register $v0 and move it in $a1 to pass it in insertNode function
li $v0, 4			 
la $a0, id
syscall


li $v0, 5
syscall
move $a1, $v0 #a1 = id 


#####read the value in register $v0 and move it in $a0 to pass it in insertNode function
#read value
li $v0, 4			 
la $a0, value
syscall

li $v0, 5
syscall
move $a0, $v0 #a0 = value 


#####move the tail of the list in register $a2

move $a2, $s2 

jal insertNode

move $s2,$v0
add $s3,$s3,1

li $v0,4
la $a0, newline
syscall
li $v0,4
la $a0, newline
syscall

j end_label
######################################
#-CHOICE 3
#####################################

else_label2:
bne $t0,3,else_label3
li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print3
syscall
	
li $v0,4
la $a0, newline
syscall

move $a2, $s2 

jal deleteLastNode

move $s2,$v0
addi $s3,$s3,-1

li $v0,4
la $a0, newline
syscall
li $v0,4
la $a0, newline
syscall


j end_label

######################################
#-CHOICE 4
#####################################

else_label3:
bne $t0,4,else_label4

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print4
syscall	

li $v0,4
la $a0, newline
syscall

#####read the id in register $v0 and move it in $a1 to pass it in printNode function
li $v0, 4			 
la $a0, id
syscall


li $v0, 5
syscall
move $a1, $v0 #a1 = id 
move $a2, $s3 #a2 = size
move $a3, $s1 #a3 = head

jal printNode

li $v0,4
la $a0, newline
syscall

li $v0,4
la $a0, newline
syscall

j end_label

####################################
#-CHOICE 5
####################################
else_label4:
bne $t0,5,else_label5

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print5
syscall	

li $v0,4
la $a0, newline
syscall

move $a1, $s3
jal printSizeOfList
move $s3,$v0

li $v0,4
la $a0, newline
syscall

li $v0,4
la $a0, newline
syscall

j end_label

####################################
#-CHOICE 6
####################################
else_label5:
bne $t0,6,else_label6

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print6
syscall	

li $v0, 4
la $a0, newline
syscall

#####read the id in register $v0 and move it in $a1 to pass it in printAddrNode function
li $v0, 4			 
la $a0, id
syscall


li $v0, 5
syscall
move $a1, $v0 #a1 = id 
move $a2, $s3 #a2 = size
move $a3, $s1 #a3 = head

jal printAddrNode

li $v0,4
la $a0, newline
syscall

li $v0,4
la $a0, newline
syscall

j end_label

####################################
#-CHOICE 7
####################################
else_label6:
bne $t0,7,else_label7

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print7
syscall	

li $v0,4
la $a0, newline
syscall

move $a1,$s1

jal printAddrList

li $v0,4
la $a0, newline
syscall

li $v0,4
la $a0, newline
syscall

j end_label

####################################
#-CHOICE 8
####################################
else_label7:
bne $t0,8,else_label8

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print8
syscall	

li $v0,4
la $a0, newline
syscall

move $a0, $s1	#head
move $a1,$s3    #size	

jal printMinVal

move $s4,$v0 #save the min

li $v0,4
la $a0, newline
syscall

li $v0,4
la $a0, newline
syscall

j end_label

####################################
#-CHOICE 9
####################################

else_label8:
bne $t0,9,else_label9

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print9
syscall	

move $a2, $s3 #a2 = size
move $a3, $s1 #a3 = head

jal sortList

j exit_label

####################################
#-CHOICE 10
####################################

else_label9:
bne $t0,10,end_label

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, Menu_Print10
syscall	

j exit_label
####################################

end_label:

j restart

exit_label:


# Exit
li  $v0, 10
syscall




#############################################
#FUNCTIONS
############################################

createList:

move $t0,$a1  #t0=id
move $t1,$a0  #t1=value
move $t2,$a2  #t2=head
  
sw $t0, 0($t2)            #id
add $t2, $t2, 4	           #move head address

sw $t1, 0($t2) 		 #value
add $t2, $t2, 4	         #move head address

lw $t3,4($t2)             #next
sw  $t3, 0($t2)  	 #save the next address

add $t2, $t2, 4	         #move head address for the next node

move $a2, $t2

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, CreateList
syscall	

li $v0,4
la $a0, newline
syscall
li $v0,4
la $a0, newline
syscall

move $v0,$a2

jr $ra

##########################################################################
insertNode:

move $t0,$a1  #t0=id
move $t1,$a0  #t1=value
move $t2,$a2  #t2=tail
  
sw $t0, 0($t2)            #id
add $t2, $t2, 4	           #move address

sw $t1, 0($t2) 		 #value
add $t2, $t2, 4	         #move address

lw $t3,4($t2)             #next
sw  $t3, 0($t2)  	 #save the next address

add $t2, $t2, 4	         #move address for the next node

move $a2, $t2

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, insert
syscall	

li $v0,4
la $a0, newline
syscall
li $v0,4
la $a0, newline
syscall

move $v0,$a2

jr $ra

###################################################################
deleteLastNode:

move $t2,$a2  #t2=tail
addi $t2, $t2, -12 #new tail
move $a2, $t2 #move new tail

li $v0,4
la $a0, newline
syscall

li $v0, 4
la $a0, delete
syscall	

li $v0,4
la $a0, newline
syscall
li $v0,4
la $a0, newline
syscall

move $v0,$a2 #move new tail

jr $ra
############################################################
printNode:

move $t1, $a1   #t1 = id 
move $t2, $a2   #t2 = size
move $t3, $a3   #t3 = head

li $t0,0

loop:
bge $t0, $t2, end_loop
lw $t4, 0($t3)

bne $t4,$t1,else    #if

li $v0,4
la $a0, newline
syscall
li $v0,4
la $a0, newline
syscall

li $v0, 4			 
la $a0, idprn
syscall
li $v0, 1
move $a0, $t4       #id printing
syscall


addi $t3, $t3, 4
lw $t4,0($t3)

li $v0,4
la $a0, newline
syscall



li $v0, 4			 
la $a0, valprn
syscall
li $v0, 1
move $a0, $t4       #value printing
syscall

li $v0,4
la $a0, newline
syscall

j end_loop

else:
addi $t3, $t3, 12   #next node
addi $t0, $t0, 1  #counter+=1
j  loop

end_loop:

jr $ra

############################################################
printSizeOfList:

move $t3,$a1


li $v0, 4
la $a0, size
syscall
 
li $v0, 1
move $a0, $t3 
syscall

li $v0,4
la $a0, newline
syscall
li $v0,4
la $a0, newline
syscall

move $v0,$t3

jr $ra

#######################################################

printAddrList:

move $t1,$a1

li $v0, 4			 
la $a0, addr
syscall

li $v0, 1
move $a0, $t1
syscall

li $v0,4
la $a0, newline
syscall
li $v0,4
la $a0, newline
syscall

jr $ra


######################################################
printAddrNode:


move $t1, $a1   #t1 = id 
move $t2, $a2   #t2 = size
move $t3, $a3   #t3 = head

li $t0,0

loop2:
bge $t0, $t2, end_loop2 #loop
lw $t4, 0($t3)

bne $t4,$t1,else2    #if

li $v0,4
la $a0, newline
syscall
li $v0,4
la $a0, newline
syscall

li $v0, 4			 
la $a0, addrnode
syscall
li $v0, 1
move $a0, $t3     #node's address printing
syscall

li $v0,4
la $a0, newline
syscall
li $v0,4
la $a0, newline
syscall

j end_loop2

else2:
addi $t3, $t3, 12   #next node
addi $t0, $t0, 1  #counter+=1
j  loop2

end_loop2:

jr $ra

#######################################################################
printMinVal:

	move $t1, $a0	#t1 has the beginning of array
	move $t2, $a1	#t2 has the number of elements
	li $t4, 100		#t4 will hold the minimum element value
	li $t5, 0 		#t5 will hold the minimum element address
        addi $t1, $t1, 4
minimum_loop:

	lw $t3, 0($t1)	#t3 holds the element

	bgt $t3, $t4, new_min	#if new element is bigger than max branch
	addi $t1, $t1, 12		#address +12
	addi $t2, $t2, -1		#counter - 1

	bne $t2, $zero, minimum_loop	#if counter != 0 go to loop
	b endloop						#else go to end_loop

new_min:
	move $t4, $t3			#update min value
	move $t5, $t1			#update min address
	addi $t1, $t1, 12		#address +12
	addi $t2, $t2, -1		#counter - 1

	bne $t2, $zero, minimum_loop	#if counter != 0 go to loop
	

endloop:
        li $v0,4
        la $a0, newline
        syscall

        li $v0, 4			 
        la $a0, minval
        syscall
        li $v0, 1
        move $a0, $t3     #min val printing
        syscall

	li $v0,4
        la $a0, newline
        syscall

        li $v0, 4			 
        la $a0, minvaladdr
        syscall
        li $v0, 1
        move $a0, $t1     #min val address printing
        syscall

        li $v0,4
        la $a0, newline
        syscall

        li $v0,4
	la $a0, newline
	syscall
        move $s4,$t3 #αποθηκεύω το min στον s4
        move $v0, $t3 #επιστρέφω το min
	
	jr $ra

###############################################
sortList:
        
        subu $sp,$sp,32    	#η στοιβα πλαισίου έχει μήκος 32 byte
        sw $ra,20($sp) 	   	#αποθήκευση της διεύθυνσης επιστροφής 
        sw $fp,16($sp) 		#αποθήκευση του δείκτη πλαισίου
        addiu $fp,$sp,28 	#ρύθμιση του δείκτη πλαισίου
        sw $a2,0($fp) 		#αποθήκευση του ορίσματος size
        sw $a3,4($fp) 		#αποθήκευση του ορίσματος head

        lw $v0, 0($fp) 	#φόρτωση του size
        bgtz $v0, L2 	#διακλάδωση αν size>0
        j L1 		#άλμα στον κώδικα επιστροφής
         
        L1:
         
           lw $ra, 20($sp)	 #επαναφορά του sp
           lw $fp,16($sp)	 #επαναφορά του fp
           addiu $sp,$sp,32	 #εξαγωγή απ'την στοίβα
           jr $ra

        L2:
	  lw $a2,0($fp)		 #φορτωση του size
	  lw $a3,4($fp)		 #φόρτωση του head

          ###########????????????????????????????????????????##############
          ###########κωδικας εύρεσης min και διευθυνσης min ##############
          ###########???????????????????????????????????????##############

          j swap_label 
          
                after_swap:

          	addi $a2,$a2,-1       #μείωση του size κατα 1
          	sw $a2,0($fp)         #αποθήκευση του καινουριου size

          	add $a3,$a3,12        #μετακίνηση του head στον επόμενο κόμβο ώστε την επόμενη φορά να ψάξει το min των (size-1) values
          	sw $a3,4($fp) 	      #αποθήκευση του νέου head

	  	jal sort list 	      #αναδρομική κλήση

      swap_label:

          move $t9,$a3 		#αποθηκεύω στον t9 το head
          move $t8,$s4 		#αποθηκεύω το min στον t8
          
          move $t7, 4($t9) 	#αποθηκεύω το value του πρώτου κόμβου στον $t7
          sw $t8, 4($t9) 	#βάζω το μικρότερο value στο πρώτο κόμβο
  
          j after_swap

  




