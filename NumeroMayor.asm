# Sección de datos / declaración de variables
.data
    # Mensajes a mostrar al usuario
    msg1: .asciiz "Introduce el primer número: "
    msg2: .asciiz "Introduce el segundo número: "
    msg3: .asciiz "Introduce el tercer número: "
    msg4: .asciiz "El número mayor es: "

    # Variables para almacenar los números ingresados
    num1: .word 0
    num2: .word 0
    num3: .word 0
    
    # Variable para almacenar el número mayor
    mayor: .word 0

# Sección de código
.text
main:
    # Pide el primer número al usuario
    la $a0, msg1      # Carga la dirección del mensaje msg1 en el registro $a0
    li $v0, 4         # Carga el código de la llamada al sistema 4 (imprimir cadena) en el registro $v0
    syscall           # Llama al sistema para imprimir el mensaje
    li $v0, 5         # Carga el código de la llamada al sistema 5 (leer entero) en el registro $v0
    syscall           # Llama al sistema para leer el número introducido
    sw $v0, num1      # Guarda el número en la variable num1

    # Pide el segundo número al usuario
    la $a0, msg2      # Carga la dirección del mensaje msg2 en el registro $a0
    li $v0, 4         # Carga el código de la llamada al sistema 4 (imprimir cadena) en el registro $v0
    syscall           # Llama al sistema para imprimir el mensaje
    li $v0, 5         # Carga el código de la llamada al sistema 5 (leer entero) en el registro $v0
    syscall           # Llama al sistema para leer el número introducido
    sw $v0, num2      # Guarda el número en la variable num2

    # Pide el tercer número al usuario
    la $a0, msg3      # Carga la dirección del mensaje msg3 en el registro $a0
    li $v0, 4         # Carga el código de la llamada al sistema 4 (imprimir cadena) en el registro $v0
    syscall           # Llama al sistema para imprimir el mensaje
    li $v0, 5         # Carga el código de la llamada al sistema 5 (leer entero) en el registro $v0
    syscall           # Llama al sistema para leer el número introducido
    sw $v0, num3      # Guarda el número en la variable num3

    # Compara los tres números para determinar cuál es el mayor
    lw $t0, num1      	# Carga el valor de num1 en el registro temporal $t0
    lw $t1, num2      	# Carga el valor de num2 en el registro temporal $t1
    lw $t2, num3      	# Carga el valor de num3 en el registro temporal $t2
    slt $t3, $t0, $t1 	# Compara t0 con t1 y guarda el resultado en $t3 (1 si t0 < t1, 0 en caso contrario)
    beq $t3, 1, mayor_t1_t0 	# Salta a la etiqueta mayor_t1_t0 si t0 < t1
    slt $t3, $t0, $t2    	# Compara t0 y t2, si t0<t2, $t3=1, sino $t3=0
    beq $t3, 1, mayor_t2_t0   	# Si $t3=1, salta a mayor_t2_t0
    j mayor_t2_t1 		# Salta a la etiqueta mayor_t2_t1

# Etiquetas
mayor_t1_t0:
    # Compara num2($t1) y num3($t2)
    slt $t3, $t1, $t2
    beq $t3, 1, resultado_t2  # Si num2($t1) < num3($t2), num3($t2) es el mayor (salta a resultado_t2)
    j resultado_t1  # De lo contrario, num2($t1) es el mayor (salta a resultado_t1)

mayor_t2_t0:
   # Compara num3($t2) y num2($t1)
   slt $t3, $t2, $t1
   beq $t3, 1, resultado_t1  # Si num3($t2) < num2($t1), num2($t1) es el mayor (salta a resultado_t1)
   j resultado_t2  # De lo contrario, num3($t2) es el mayor (salta a resultado_t2)

mayor_t2_t1:
   # Compara num3($t2) y num1($t0)
   slt $t3, $t2, $t0
   beq $t3, 1, resultado_t0  # Si num3($t2) < num1($t0), num1($t0) es el mayor (salta a resultado_t0)
   j resultado_t2  # De lo contrario, num3($t2) es el mayor (salta a resultado_t2)

resultado_t0:
   # El número mayor es num1
    lw $a0, num1     # Carga el valor de num1 en el registro $a0
    j resultado      # Salta a la etiqueta resultado para mostrar el número mayor

resultado_t1:
    # El número mayor es num2
    lw $a0, num2    # Carga el valor de num2 en el registro $a0
    j resultado     # Salta a la etiqueta resultado para mostrar el número mayor

resultado_t2:
    # El número mayor es num3
    lw $a0, num3   # Carga el valor de num3 en el registro $a0

resultado:
    # Muestra el resultado en pantalla
    
    sw $a0, mayor   # Almacena el valor del número mayor en la variable "mayor"

    # Imprime el mensaje sin el número mayor, es decir, la primera parte del mensaje sin el resultado
    la $a0, msg4    # Carga la dirección de memoria del mensaje "El número mayor es: " en $a0
    li $v0, 4       # Carga el valor 4 en $v0 para indicar que se mostrará una cadena de caracteres
    syscall	    # Realiza la llamada al sistema para mostrar la cadena de caracteres

    # Imprime el número mayor
    lw $a0, mayor   # Carga el valor del número mayor desde la variable "menor" en $a0
    li $v0, 1	    # Carga el valor 1 en $v0 para indicar que se mostrará un entero
    syscall	    # Realiza la llamada al sistema para mostrar el valor del número mayor

    # Salida del programa
    li $v0, 10	    # Carga el valor 10 en $v0 para indicar que se terminará la ejecución del programa
    syscall	    # Realiza la llamada al sistema para terminar la ejecución del programa
