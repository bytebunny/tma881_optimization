	.file	"time_sum.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Enter number of times summation should be repeated: "
.LC2:
	.string	"%d"
.LC4:
	.string	"\nThe sum of the first %e integers is %zu.\n"
.LC5:
	.string	"Elapsed time of summation %zu: %.9lf sec.\n"
.LC6:
	.string	"\nThe average elapsed time is %.9lf sec.\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$.LC1, %edi
	xorl	%eax, %eax
	xorl	%ebx, %ebx
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	call	printf
	leaq	28(%rsp), %rsi
	movl	$.LC2, %edi
	xorl	%eax, %eax
	call	__isoc99_scanf
	xorps	%xmm2, %xmm2
.L2:
	movslq	28(%rsp), %rdx
	cmpq	%rbx, %rdx
	jbe	.L6
	movl	$1, %esi
	leaq	32(%rsp), %rdi
	movsd	%xmm2, (%rsp)
	incq	%rbx
	call	timespec_get
	movl	$1, %esi
	leaq	48(%rsp), %rdi
	call	timespec_get
	movq	56(%rsp), %rax
	subq	40(%rsp), %rax
	movabsq	$500000000500000000, %rsi
	cvtsi2sdq	%rax, %xmm1
	movq	48(%rsp), %rax
	subq	32(%rsp), %rax
	movl	$.LC4, %edi
	movsd	.LC3(%rip), %xmm3
	cvtsi2sdq	%rax, %xmm0
	movsd	(%rsp), %xmm2
	movb	$1, %al
	divsd	%xmm3, %xmm1
	addsd	%xmm0, %xmm1
	movapd	%xmm3, %xmm0
	addsd	%xmm1, %xmm2
	movsd	%xmm1, 8(%rsp)
	movsd	%xmm2, (%rsp)
	call	printf
	movsd	8(%rsp), %xmm1
	movq	%rbx, %rsi
	movb	$1, %al
	movl	$.LC5, %edi
	movapd	%xmm1, %xmm0
	call	printf
	movsd	(%rsp), %xmm2
	jmp	.L2
.L6:
	cvtsi2sdl	%edx, %xmm0
	movl	$.LC6, %edi
	movb	$1, %al
	divsd	%xmm0, %xmm2
	movapd	%xmm2, %xmm0
	call	printf
	addq	$64, %rsp
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 9.1.1 20190503 (Red Hat 9.1.1-1)"
	.section	.note.GNU-stack,"",@progbits
