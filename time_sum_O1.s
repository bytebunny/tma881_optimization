	.file	"time_sum.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"Enter number of times summation should be repeated: "
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%d"
	.section	.rodata.str1.8
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
.LFB11:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	leaq	60(%rsp), %rsi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	movl	60(%rsp), %eax
	testl	%eax, %eax
	je	.L5
	movl	$0, %ebx
	pxor	%xmm6, %xmm6
	movsd	%xmm6, (%rsp)
.L4:
	movl	$1, %esi
	leaq	32(%rsp), %rdi
	call	timespec_get
	movl	$1000000000, %eax
.L3:
	subq	$1, %rax
	jne	.L3
	movl	$1, %esi
	leaq	16(%rsp), %rdi
	call	timespec_get
	movq	24(%rsp), %rax
	subq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC3(%rip), %xmm2
	divsd	%xmm2, %xmm0
	movq	16(%rsp), %rax
	subq	32(%rsp), %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movapd	%xmm0, %xmm3
	addsd	%xmm1, %xmm3
	movsd	(%rsp), %xmm4
	movsd	%xmm3, 8(%rsp)
	addsd	%xmm3, %xmm4
	movsd	%xmm4, (%rsp)
	movabsq	$500000000500000000, %rsi
	movapd	%xmm2, %xmm0
	movl	$.LC4, %edi
	movl	$1, %eax
	call	printf
	addq	$1, %rbx
	movsd	8(%rsp), %xmm0
	movq	%rbx, %rsi
	movl	$.LC5, %edi
	movl	$1, %eax
	call	printf
	movl	60(%rsp), %eax
	movslq	%eax, %rdx
	cmpq	%rdx, %rbx
	jb	.L4
.L2:
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movsd	(%rsp), %xmm5
	divsd	%xmm0, %xmm5
	movapd	%xmm5, %xmm0
	movl	$.LC6, %edi
	movl	$1, %eax
	call	printf
	movl	$0, %eax
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	pxor	%xmm7, %xmm7
	movsd	%xmm7, (%rsp)
	jmp	.L2
	.cfi_endproc
.LFE11:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 9.1.1 20190503 (Red Hat 9.1.1-1)"
	.section	.note.GNU-stack,"",@progbits
