# Sección de datos / declaración de variables
.data

# Mensajes a mostrar al usuario
msg1: .asciiz "Ingresa el primer número: "
msg2: .asciiz "Ingresa el segundo número: "
msg3: .asciiz "Ingresa el tercer número: "
msg4: .asciiz "El número menor es: "

# Variables para almacenar los números ingresados
num1: .word 0
num2: .word 0
num3: .word 0

# Variable para almacenar el número menor
menor: .word 0

# Sección de código
.text
# Declara "main" como global para que pueda ser accedida desde cualquier parte
.globl main
main:
    # Imprime mensaje para ingresar el primer número
    la $a0, msg1     # Carga en $a0 la dirección del mensaje msg1
    li $v0, 4        # Carga en $v0 el valor 4 para indicar que se imprime un string
    syscall          # Llama al servicio de impresión de string

    # Lee el primer número ingresado
    li $v0, 5        # Carga en $v0 el valor 5 para indicar que se lee un número entero
    syscall          # Llama al servicio de lectura de número entero
    sw $v0, num1     # Almacena el número ingresado en la variable num1

    # Imprime mensaje para ingresar el segundo número
    la $a0, msg2     # Carga en $a0 la dirección del mensaje msg2
    li $v0, 4        # Carga en $v0 el valor 4 para indicar que se imprime un string
    syscall          # Llama al servicio de impresión de string

    # Lee el segundo número ingresado
    li $v0, 5        # Carga en $v0 el valor 5 para indicar que se lee un número entero
    syscall          # Llama al servicio de lectura de número entero
    sw $v0, num2     # Almacena el número ingresado en la variable num2

    # Imprime mensaje para ingresar el tercer número
    la $a0, msg3     # Carga en $a0 la dirección del mensaje msg3
    li $v0, 4        # Carga en $v0 el valor 4 para indicar que se imprime un string
    syscall          # Llama al servicio de impresión de string

    # Lee el tercer número ingresado
    li $v0, 5        # Carga en $v0 el valor 5 para indicar que se lee un número entero
    syscall          # Llama al servicio de lectura de número entero
    sw $v0, num3     # Almacena el número ingresado en la variable num3

    # Compara los tres números para determinar cuál es el menor
    lw $t0, num1	# Carga el primer número en el registro $t0
    lw $t1, num2	# Carga el segundo número en el registro $t1
    lw $t2, num3	# Carga el tercer número en el registro $t2
    # Compara $t0 con $t1 y guarda el resultado en $t3.
    slt $t3, $t0, $t1	# Si $t0 es menor que $t1, entonces $t3 será 1; de lo contrario, será 0.

    # Si $t0 es menor que $t1, salta a la etiqueta "menor_t0_t1".
    # De lo contrario, continúa con la comparación entre $t1 y $t2.
    beq $t3, 1, menor_t0_t1

    # Compara $t1 con $t2 y guarda el resultado en $t3.
    # Si $t1 es menor que $t2, entonces $t3 será 1; de lo contrario, será 0.
    slt $t3, $t1, $t2	

    # Si $t1 es menor que $t2, salta a la etiqueta "menor_t1_t2".
    # De lo contrario, salta a la etiqueta "menor_t2_t3".
    beq $t3, 1, menor_t1_t2	
    j menor_t2_t3	# Salta a la etiqueta "menor_t2_t3"
    
#Etiquetas
menor_t0_t1:

    # Compara $t0 con $t2 y guarda el resultado en $t3.
    # Si $t0 es menor que $t2, entonces $t3 será 1; de lo contrario, será 0.
    slt $t3, $t0, $t2

    # Si $t0 es menor que $t2, salta a la etiqueta "resultado_t0".
    # De lo contrario, 
    beq $t3, 1, resultado_t0
    j resultado_t2	# Salta a la etiqueta "resultado_t2".    	

menor_t1_t2:
    
    # Compara $t1 con $t0 y guarda el resultado en $t3.
    # Si $t1 es menor que $t0, entonces $t3 será 1; de lo contrario, será 0.
    slt $t3, $t1, $t0

    # Si $t1 es menor que $t0, salta a la etiqueta "resultado_t1".
    # De lo contrario, salta a la etiqueta "resultado_t0".
    beq $t3, 1, resultado_t1
    j resultado_t0 	# Salta a la etiqueta "resultado_t0".

menor_t2_t3:

    # Compara $t2 con $t1 y guarda el resultado en $t3.
    # Si $t2 es menor que $t1, entonces $t3 será 1; de lo contrario, será 0.
    slt $t3, $t2, $t1	

    # Si $t2 es menor que $t1, salta a la etiqueta "resultado_t2".
    # De lo contrario, salta a la etiqueta "resultado_t1".
    beq $t3, 1, resultado_t2
    j resultado_t1	# Salta a la etiqueta "resultado_t1".

resultado_t0:
    # El número menor es num1
    lw $a0, num1      # Carga el valor de num1 en el registro $a0
    j resultado       # Salta a la etiqueta resultado para mostrar el número menor

resultado_t1:
    # El número menor es num2
    lw $a0, num2      # Carga el valor de num2 en el registro $a0
    j resultado       # Salta a la etiqueta resultado para mostrar el número menor

resultado_t2:
    # El número menor es num3
    lw $a0, num3      # Carga el valor de num3 en el registro $a0

resultado:
    # Muestra el resultado en pantalla

    sw $a0, menor     # Almacena el valor del número menor en la variable "menor"

    # Imprime el mensaje sin el número menor, es decir, la primera parte del mensaje sin el resultado
    la $a0, msg4      # Carga la dirección de memoria del mensaje "El número menor es: " en $a0
    li $v0, 4         # Carga el valor 4 en $v0 para indicar que se mostrará una cadena de caracteres
    syscall           # Realiza la llamada al sistema para mostrar la cadena de caracteres

    # Imprime el número menor
    lw $a0, menor     # Carga el valor del número menor desde la variable "menor" en $a0
    li $v0, 1         # Carga el valor 1 en $v0 para indicar que se mostrará un entero
    syscall           # Realiza la llamada al sistema para mostrar el valor del número menor

    # Salida del programa
    li $v0, 10        # Carga el valor 10 en $v0 para indicar que se terminará la ejecución del programa
    syscall           # Realiza la llamada al sistema para terminar la ejecución del programa

