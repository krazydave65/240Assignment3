;========1=========2=========3=========4=========5=========6=========7=========8
;Author information
;  Author name: David Pedroza
;  Author email: krazydave65@fullerton.edu
;Course information
;  Course number: CPSC240
;  Assignment number: 3
;  Due date: 2014-Sep-29
;Project information
;  Project title: Condensed Amortization Schedule
;  Purpose: Find the total Current and Total Power by adding and diving ymm Registers
;  Status: No known errors
;  Project files: p3Driver.c, p3Main.asm, calc.c
;Module information
;  This module's call name: computeymmsum
;  Language: X86-64
;  Syntax: Intel
;  Date last modified: 2014-Sept-28
;  Purpose: This module will perform the addition of 4 qword fp numbers
;  File name: p3Main.asm
;  Status: In production.  No known errors.
;  Future enhancements: None planned
;Translator information
;  Linux: nasm -f elf64 -l p3Main.lis -o p3Main.o p3Main.asm

;Format information
;  Page width: 310 columns
;  Begin comments: 28
;  Optimal print specification: Landscape,  monospace, 8Â½x11 paper
;
;===== Begin code area ======================================================
extern printf, scanf ;External C function for writing to standard output device

extern calc

global p3            ;This makes p3Main callable by functions outside
                     ;of this file.

segment .bss
regSave resb 831


segment .data        ;Place initialized data here
%include "debug.inc"

;===== Declare some messages =================================================

welcome1 db "Welcome to the bank of Catalina Island",10, 0
welcome2 db "David Pedroza, Chief Loan Officer",10,10, 0

promptInterest db "Please enter the current interest rate as a float number: ", 0
promptLoans db "Enter the amount of four loans: ",0
promptMonths db "Enter the time of the loans as a whole number of months: ",0
promptPrint db "Condensed amortization schedules for the four possible loans are as follows.",10,10,0

printLoanAmount db "Loan amounts  :          %1.2lf    %1.2lf    %1.2lf    %1.2lf",10,0
printMonthlyPayment db "Montly payment amount:     %1.2lf    %1.2lf    %1.2lf    %1.2lf",10,0
printInterestText db "Interest due by months: ",0
printInterestDue db "   %1.2lf      %1.2lf       %1.2lf      %1.2lf",10,0
printInterestDue2 db 9,9,9,"    %1.2lf      %1.2lf       %1.2lf     %1.2lf",10,0
printTotalInterest db "Total Interest:            %1.2lf       %1.2lf      %1.2lf     %1.2lf",10,0
printDebug db "Total interest: %1.2lf",10,0


;================ Input formats ===========================================
singleFloat db "%lf",0
inputFormat db "%1.2lf",0
monthsFormat db "%ld",0       ; input format
outputFormat db 10,"%1.2lf  %1.2lf  %1.2lf  %1.2lf",10,0
floatFormat db "%1.2lf",10,0

two dq 12.0, 12.0 ,12.0 ,12.0
zero dq 0.00, 0.00, 0.00, 0.00

segment .text                                    ;Place executable instructions in this segment.

p3:                                              ;Entry point.  Execution begins here.






;=========== Back up all the integer registers used in this program ==========

push       rbp                            ;Save a copy of the stack base pointer
mov        rbp, rsp                        ;We do this in order to be 100% compatible with C and C++.
push       rbx                             ;Back up rbx
push       rcx                             ;Back up rcx
push       rdx                             ;Back up rdx
push       rsi                             ;Back up rsi
push       rdi                             ;Back up rdi
push       r8                              ;Back up r8
push       r9                              ;Back up r9
push       r10                             ;Back up r10
push       r11                             ;Back up r11
push       r12                             ;Back up r12
push       r13                             ;Back up r13
push       r14                             ;Back up r14
push       r15                             ;Back up r15
pushf                                      ;Back up rflags







;=======================================================================

;=========== Begin the application here: ===============================
;=======================================================================



;======== Welcome1 ==================================
mov     rax, 0                       ;No data from SSE will be printed
mov     rdi, welcome1                ;"Welcome to the bank of Catalina Island",10,0
call    printf                       ;Call a library function to make the output

;======== Welcome2 ==================================
mov     rax, 0                       ;No data from SSE will be printed
mov     rdi, welcome2                ;"David Pedroza, Chief Loan Officer",10,0
call    printf                       ;Call a library function to make the output


;======== promptIntrest ==================================
mov     rax, 0                       ;No data from SSE will be printed
mov     rdi, promptInterest          ;"Please enter the current interest rate as a float number: ",10,0
call    printf                       ;Call a library function to make the output


;============== Interest Input =================================
push qword 0                         ;reserve 8 bytes of storage for the incoming number
mov  rax, 0                          ;SSE is NOT involved in this scanf operation
mov  rdi,singleFloat                 ;"%lf"
mov  rsi, rsp                        ;Give scanf a point to the reserved storage
call  scanf                          ;Call a library function to do the input work
vbroadcastsd  ymm15, [rsp]           ;broadcast interest to the ymm15 register
pop rax                              ; pop --> [rsp]


;============== 4x Loan inputs ==================================
mov    rax, 0                        ;No data from SSE will be printed
mov    rdi, promptLoans              ;"Enter the amount of four loans: "
call   printf                        ;Call a library function to make the output

push qword 0                         ;reserve 8 bytes of storage for the incoming number
mov  rax, 0                          ;SSE is NOT involved in this scanf operation
mov  rdi,singleFloat                 ;"%lf"
mov  rsi, rsp                        ;Give scanf a point to the reserved storage
call  scanf                          ;Call a library function to do the input work

push qword 0                         ;reserve 8 bytes of storage for the incoming number
mov  rax, 0                          ;SSE is NOT involved in this scanf operation
mov  rdi,singleFloat                 ;"%lf"
mov  rsi, rsp                        ; Give scanf a point to the reserved storage
call  scanf
                                     ; Call a library function to do the input work
push qword 0                         ; reserve 8 bytes of storage for the incoming number
mov  rax, 0                          ; SSE is NOT involved in this scanf operation
mov  rdi,singleFloat                 ; "%lf"
mov  rsi, rsp                        ; Give scanf a point to the reserved storage
call  scanf
                                     ; Call a library function to do the input work
push qword 0                         ; reserve 8 bytes of storage for the incoming number
mov  rax, 0                          ; SSE is NOT involved in this scanf operation
mov  rdi,singleFloat                 ; "%lf"
mov  rsi, rsp                        ; Give scanf a point to the reserved storage
call  scanf                          ; Call a library function to do the input work

vmovupd  ymm14,[rsp]                 ;move 4 values in stack to ymm14
pop    rax                           ;pop ---> [rsp]
pop    rax                           ;pop ---> [rsp]
pop    rax                           ;pop ---> [rsp]
pop    rax                           ;pop ---> [rsp]


;============== Months Input =================================
mov    rax, 0                       ;No data from SSE will be printed
mov    rdi, promptMonths            ;"Enter the time of the loans as a whole number of months: "
call   printf

push qword 0                        ; reserve 8 bytes of storage for the incoming number
mov  rax, 0                         ; SSE is NOT involved in this scanf operation
mov  rdi, monthsFormat              ;%ld
mov  rsi, rsp                       ; Give scanf a point to the reserved storage
call  scanf                         ; Call a library function to do the input work

mov  r13, [rsp]                     ; copy months to r13.... waiting to send to 4 loop
;cvtsd2si r

vbroadcastsd  ymm13, [rsp]          ; copy [rsp] to ymm13
pop    rax




;============= Call Function for Loan 1 =====================================
mov rdi, r13                        ;rdi <-- copy r13 = months
                                    ;function takes months from rdi


vextractf128  xmm0, ymm15, 1        ;position interest --> xmm0
vextractf128  xmm2, ymm14, 1        ;position loan to -->xmm1
movhlps       xmm1, xmm2

call calc

push qword 0                        ;make space in stack
push qword 0                        ;make space in stack
push qword 0                        ;make space in stack
push qword 0                        ;make space in stack

mov rsi, rsp                        ;position loan to --> xmm1
add rsi, 24
movsd [rsi], xmm0

;============= Call Function for Loan 2 =====================================
mov rdi, r13                         ;rdi <-- copy r13 = months
                                     ;function takes months from rdi


vextractf128  xmm0, ymm15, 1         ;position interest --> xmm0
vextractf128  xmm1, ymm14, 1         ;position loan to -->xmm1

call calc                            ;call the calc.c function

mov rdx, rsp                         ;move monthly_payment to register
add rdx, 16
movsd [rdx],xmm0


;============= Call Function for Loan 3 =====================================
mov rdi, r13                        ;rdi <-- copy r13 = months
                                    ;function takes months from rdi


vextractf128  xmm0, ymm15, 1        ;position interest --> xmm0
movhlps  xmm1, xmm14                ;position loan to -->xmm1

call calc                           ;call the calc.c function

mov rcx, rsp                        ;move monthly_payment to register
add rcx, 8
movsd [rcx],xmm0


;============= Call Function for Loan 4 =====================================
mov rdi, r13                        ;rdi <-- copy r13 = months
                                    ;function takes months from rdi


vextractf128  xmm0, ymm15, 1        ;position interest --> xmm0
movsd  xmm1, xmm14                  ;position loan to -->xmm1
call calc
movsd [rsp],xmm0                    ;move monthly_payment to register



;===== Moving Monthly Payments to ymm register ================
vmovupd ymm8, [rsp]                 ;monthly pay --> ymm8
pop rbx                             ;pop --> register
pop rcx                             ;pop --> register
pop rdx                             ;pop --> register
pop rsi                             ;pop --> register


;== Broadcast 2 --> ymm9 ============
vmovupd ymm9, [two]					;move [two] = {12,12,12,12} --> ymm9

;== Broadcast 2 --> ymm12 ============
vmovupd ymm12, [zero]				;set ymm12 to zeros

;======== MESSAGE: the loans are as follows ==================
mov    rax, 0                       ;No data from SSE will be printed
mov    rdi, promptPrint             ;"Condensed amortization schedules for the four possible loans are as follows."
call   printf


;======== Print Loan Amounts =================================
vextractf128  xmm1,ymm14, 1         ;move ymm registers(monthly payment) to lower SSE
vmovhlps      xmm0, xmm1
vextractf128  xmm3,ymm14, 0
vmovhlps      xmm2, xmm3

mov    rax, 4                       ;No data from SSE will be printed
mov    rdi, printLoanAmount         ;"Loan amounts  :    %1.2lf   %1.2lf   %1.2lf   %1.2lf"
call   printf

;======== Print Monthly Payment =================================
vextractf128  xmm1,ymm8, 1          ;move ymm registers(monthly payment) to lower SSE
vmovhlps      xmm0, xmm1            ; registers for printf
vextractf128  xmm3,ymm8, 0
vmovhlps      xmm2, xmm3

mov    rax, 4                       ;No data from SSE will be printed
mov    rdi, printMonthlyPayment     ;"Montly payment amount:     %1.2lf    %1.2lf    %1.2lf    %1.2lf"
call   printf

;====Print Interest Text===============================
mov    rax, 0                      ;No data from SSE will be printed
mov    rdi, printInterestText      ;"Interest due by months:"
call   printf





;========= Initial Data Before for Loop=========================
;===============================================================
;****** First PAID INTEREST *********************
vmulpd ymm11, ymm15, ymm14          ;paid_interest <--- mult balance * interest
vdivpd ymm11,ymm9                   ;(BAL*INTEREST)/12 ---> ymm11

;===== Print Interest Due ============================
vextractf128  xmm1,ymm11, 1          ;move ymm registers(monthly payment) to lower SSE
vmovhlps      xmm0, xmm1             ; registers for printf
vextractf128  xmm3,ymm11, 0
vmovhlps      xmm2, xmm3
mov    rax, 4                       ;No data from SSE will be printed
mov    rdi, printInterestDue        ;"MESSAGE"
call   printf

;****** Total INTEREST ************************
vaddpd ymm12, ymm11, ymm12          ;add ymm12 with ymm11 ----> ymm12 for total interest

;****** PAID_BALANCE *********************
vsubpd ymm10, ymm8, ymm11           ;paid_balance = MP - paid_interest

;****** BALANCE *********************
                                    ;position interest --> xmm0
vsubpd ymm14, ymm14, ymm10          ;balance = balance - paid_balance



;=======================================================================
;=========== Inside the for-loop =========================================
;========================================================================
mov r14, 1
mov r15, r13                        ;r15 <-- copy r13 = monthsValue

topOfLoop:                          ;Beginning of For Loop
cmp r14, r15
jge exitLoop



;****** PAID INTEREST *********************
vmulpd ymm11, ymm15, ymm14          ;paid_interest <--- mult balance * interest
vdivpd ymm11,ymm9                   ;(BAL*INTEREST)/12 ---> ymm11


;===== Print Interest Due ============================

vextractf128  xmm1,ymm11, 1          ;move ymm registers(monthly payment) to lower SSE
vmovhlps      xmm0, xmm1
vextractf128  xmm3,ymm11, 0
vmovhlps      xmm2, xmm3
mov    rax, 4                       ;No data from SSE will be printed
mov    rdi, printInterestDue2        ;" %1.2lf      %1.2lf       %1.2lf     %1.2lf"
call   printf



;****** Total INTEREST ************************
vaddpd ymm12, ymm11, ymm12           ;add registers to get total INTEREST



;****** PAID_BALANCE *********************
vsubpd ymm10, ymm8, ymm11           ;paid_balance = MP - paid_interest



;****** Total BALANCE *********************
                                    ;position interest --> xmm0
vsubpd ymm14, ymm14, ymm10          ;balance = balance - paid_balance


add r14, 1
jmp topOfLoop
exitLoop:                           ; End of for loop
;==============================================================
;========= End of Loop =========================================
;===============================================================


vextractf128  xmm1,ymm12, 1          ;move ymm registers(monthly payment) to lower SSE
vmovhlps      xmm0, xmm1             ;registers for printf
vextractf128  xmm3,ymm12, 0
vmovhlps      xmm2, xmm3


mov    rax, 4                       ;No data from SSE will be printed
mov    rdi, printTotalInterest      ;"Total Interest:     %1.2lf       %1.2lf      %1.2lf     %1.2lf""
call   printf

vextractf128  xmm0,ymm12, 0         ;move lastvalue --> xmm0 to return to Driver



;=========== Restore GPR values and return to the caller ========================

popf                                 ;Restore rflags
pop        r15                       ;Restore r15
pop        r14                       ;Restore r14
pop        r13                       ;Restore r13
pop        r12                       ;Restore r12
pop        r11                       ;Restore r11
pop        r10                       ;Restore r10
pop        r9                        ;Restore r9
pop        r8                        ;Restore r8
pop        rdi                       ;Restore rdi
pop        rsi                       ;Restore rsi
pop        rdx                       ;Restore rdx
pop        rcx                       ;Restore rcx
pop        rbx                       ;Restore rbx
pop        rbp                       ;Restore rbp

ret                                  ;Pop the integer stack and resume
                                     ;execution at the address that was popped from the stack.
;===== End of program avxdemo ============================================
;========1=========2=========3=========4=========5=========6=========7====
