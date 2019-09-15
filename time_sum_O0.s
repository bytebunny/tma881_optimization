	.file	"time_sum.c"
	.text
	.section	.rodata
	.align 8
.LC1:
	.string	"Enter number of times summation should be repeated: "
.LC2:
	.string	"%d"
	.align 8
.LC4:
	.string	"\nThe sum of the first %e integers is %zu.\n"
	.align 8
.LC5:
	.string	"Elapsed time of summation %zu: %.9lf sec.\n"
	.align 8
.LC6:
	.string	"\nThe average elapsed time is %.9lf sec.\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	$1000000000, -40(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -16(%rbp)
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	leaq	-52(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	movq	$0, -24(%rbp)
	jmp	.L2
.L7:
	movq	$0, -8(%rbp)
	leaq	-80(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	timespec_get
	movq	$1, -32(%rbp)
	jmp	.L3
.L4:
	movq	-32(%rbp), %rax
	addq	%rax, -8(%rbp)
	addq	$1, -32(%rbp)
.L3:
	movq	-40(%rbp), %rax
	addq	$1, %rax
	cmpq	%rax, -32(%rbp)
	jb	.L4
	leaq	-96(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	timespec_get
	movq	-96(%rbp), %rdx
	movq	-80(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	cvtsi2sdq	%rax, %xmm1
	movq	-88(%rbp), %rdx
	movq	-72(%rbp), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC3(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -48(%rbp)
	movsd	-16(%rbp), %xmm0
	addsd	-48(%rbp), %xmm0
	movsd	%xmm0, -16(%rbp)
	movq	-40(%rbp), %rax
	testq	%rax, %rax
	js	.L5
	cvtsi2sdq	%rax, %xmm0
	jmp	.L6
.L5:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L6:
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC4, %edi
	movl	$1, %eax
	call	printf
	movq	-24(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	-48(%rbp), %rax
	movq	%rax, %xmm0
	movq	%rdx, %rsi
	movl	$.LC5, %edi
	movl	$1, %eax
	call	printf
	addq	$1, -24(%rbp)
.L2:
	movl	-52(%rbp), %eax
	cltq
	cmpq	%rax, -24(%rbp)
	jb	.L7
	movl	-52(%rbp), %eax
	cvtsi2sdl	%eax, %xmm1
	movsd	-16(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	movl	$.LC6, %edi
	movl	$1, %eax
	call	printf
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC3:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 9.1.1 20190503 (Red Hat 9.1.1-1)"
	.section	.note.GNU-stack,"",@progbits
