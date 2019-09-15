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
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$.LC1, %edi
	xorl	%eax, %eax
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$72, %rsp
	.cfi_def_cfa_offset 96
	call	printf
	leaq	28(%rsp), %rsi
	movl	$.LC2, %edi
	xorl	%eax, %eax
	call	__isoc99_scanf
	movl	28(%rsp), %eax
	testl	%eax, %eax
	je	.L4
	movabsq	$500000000500000000, %rbp
	pxor	%xmm4, %xmm4
	xorl	%ebx, %ebx
	movsd	%xmm4, (%rsp)
.L3:
	movl	$1, %esi
	leaq	32(%rsp), %rdi
	addq	$1, %rbx
	call	timespec_get
	movl	$1, %esi
	leaq	48(%rsp), %rdi
	call	timespec_get
	pxor	%xmm1, %xmm1
	pxor	%xmm0, %xmm0
	movq	%rbp, %rsi
	movq	56(%rsp), %rax
	subq	40(%rsp), %rax
	movl	$.LC4, %edi
	cvtsi2sdq	%rax, %xmm1
	movq	48(%rsp), %rax
	subq	32(%rsp), %rax
	divsd	.LC3(%rip), %xmm1
	cvtsi2sdq	%rax, %xmm0
	movsd	(%rsp), %xmm2
	movq	.LC3(%rip), %rax
	addsd	%xmm0, %xmm1
	movq	%rax, %xmm0
	movl	$1, %eax
	addsd	%xmm1, %xmm2
	movsd	%xmm1, 8(%rsp)
	movsd	%xmm2, (%rsp)
	call	printf
	movsd	8(%rsp), %xmm1
	movq	%rbx, %rsi
	movl	$.LC5, %edi
	movl	$1, %eax
	movapd	%xmm1, %xmm0
	call	printf
	movslq	28(%rsp), %rdx
	movq	%rdx, %rax
	cmpq	%rdx, %rbx
	jb	.L3
.L2:
	pxor	%xmm0, %xmm0
	movsd	(%rsp), %xmm3
	movl	$.LC6, %edi
	cvtsi2sdl	%eax, %xmm0
	movl	$1, %eax
	divsd	%xmm0, %xmm3
	movapd	%xmm3, %xmm0
	call	printf
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L4:
	.cfi_restore_state
	pxor	%xmm5, %xmm5
	movsd	%xmm5, (%rsp)
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
