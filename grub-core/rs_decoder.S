	.file	"reed_solomon.c"
	.text
	.type	pol_evaluate, @function
pol_evaluate:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	movl	%ecx, %edi
	pushl	%esi
	movl	%eax, %esi
	pushl	%ebx
	xorl	%eax, %eax
	xorl	%ebx, %ebx
.L2:
	testl	%edx, %edx
	js	.L11
	movzbl	(%esi,%edx), %ecx
	testb	%cl, %cl
	je	.L3
	movzbl	1049088(%ecx), %ecx
	xorb	1048576(%ebx,%ecx), %al
.L3:
	addl	%edi, %ebx
	cmpl	$255, %ebx
	leal	-255(%ebx), %ecx
	cmovge	%ecx, %ebx
	decl	%edx
	jmp	.L2
.L11:
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	pol_evaluate, .-pol_evaluate
	.type	gf_mul, @function
gf_mul:
	pushl	%ebp
	testl	%eax, %eax
	movl	%esp, %ebp
	je	.L14
	testl	%edx, %edx
	je	.L14
	movzbl	1049088(%eax), %ecx
	movzbl	1049088(%edx), %eax
	movb	1048576(%ecx,%eax), %al
	jmp	.L13
.L14:
	xorl	%eax, %eax
.L13:
	popl	%ebp
	ret
	.size	gf_mul, .-gf_mul
	.type	gauss_solve.constprop.2, @function
gauss_solve.constprop.2:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$40, %esp
	movl	%eax, -24(%ebp)
	xorl	%eax, %eax
	movl	%edx, -16(%ebp)
	movl	%ecx, -32(%ebp)
.L17:
	cmpl	-24(%ebp), %eax
	jge	.L46
	movl	$-1, 1049344(,%eax,4)
	incl	%eax
	jmp	.L17
.L46:
	xorl	%eax, %eax
.L19:
	cmpl	-16(%ebp), %eax
	jge	.L47
	movl	-32(%ebp), %edx
	movb	$0, (%edx,%eax)
	incl	%eax
	jmp	.L19
.L47:
	movl	-16(%ebp), %eax
	xorl	%edi, %edi
	movl	$0, -20(%ebp)
	incl	%eax
	movl	%eax, -28(%ebp)
	movl	%eax, -48(%ebp)
.L21:
	movl	-24(%ebp), %eax
	cmpl	%eax, -20(%ebp)
	jge	.L34
	xorl	%ebx, %ebx
.L35:
	cmpl	-16(%ebp), %ebx
	jl	.L22
.L26:
	cmpl	-16(%ebp), %ebx
	je	.L27
	movl	-20(%ebp), %eax
	movl	$255, %edx
	xorl	%esi, %esi
	movl	%ebx, 1049344(,%eax,4)
	movzbl	1052672(%ebx,%edi), %eax
	movzbl	1049088(%eax), %eax
	subl	%eax, %edx
	movzbl	1048576(%edx), %eax
	movl	%eax, -36(%ebp)
	jmp	.L28
.L22:
	cmpb	$0, 1052672(%ebx,%edi)
	jne	.L26
	incl	%ebx
	jmp	.L35
.L28:
	cmpl	%esi, -16(%ebp)
	jl	.L48
	movzbl	1052672(%esi,%edi), %eax
	incl	%esi
	movl	-36(%ebp), %edx
	call	gf_mul
	movb	%al, 1052671(%esi,%edi)
	jmp	.L28
.L48:
	movl	-20(%ebp), %eax
	incl	%eax
	movl	%eax, -36(%ebp)
	movl	-48(%ebp), %eax
	leal	(%eax,%edi), %ecx
.L30:
	movl	-24(%ebp), %eax
	cmpl	%eax, -36(%ebp)
	je	.L27
	movzbl	1052672(%ebx,%ecx), %eax
	xorl	%esi, %esi
	movl	%eax, -44(%ebp)
.L31:
	cmpl	%esi, -16(%ebp)
	jl	.L49
	movb	1052672(%esi,%ecx), %al
	incl	%esi
	movl	%ecx, -52(%ebp)
	movl	-44(%ebp), %edx
	movb	%al, -37(%ebp)
	movzbl	1052671(%esi,%edi), %eax
	call	gf_mul
	movl	-52(%ebp), %ecx
	xorb	-37(%ebp), %al
	movb	%al, 1052671(%esi,%ecx)
	jmp	.L31
.L49:
	incl	-36(%ebp)
	addl	-28(%ebp), %ecx
	jmp	.L30
.L27:
	incl	-20(%ebp)
	addl	-28(%ebp), %edi
	jmp	.L21
.L34:
	movl	-24(%ebp), %ebx
	movl	-28(%ebp), %edi
	movl	-16(%ebp), %eax
	decl	%ebx
	imull	%ebx, %edi
	notl	%eax
	movl	%eax, -24(%ebp)
.L36:
	testl	%ebx, %ebx
	js	.L50
	movl	1049344(,%ebx,4), %eax
	movl	%eax, -20(%ebp)
	incl	%eax
	je	.L37
	xorl	%ecx, %ecx
	xorl	%esi, %esi
.L38:
	cmpl	-16(%ebp), %esi
	jge	.L51
	movl	-32(%ebp), %eax
	movl	%ecx, -28(%ebp)
	movzbl	(%eax,%esi), %edx
	incl	%esi
	movzbl	1052671(%esi,%edi), %eax
	call	gf_mul
	movl	-28(%ebp), %ecx
	xorl	%eax, %ecx
	jmp	.L38
.L51:
	movl	-16(%ebp), %eax
	movl	-20(%ebp), %edx
	xorb	1052672(%edi,%eax), %cl
	movl	-32(%ebp), %eax
	movb	%cl, (%eax,%edx)
.L37:
	decl	%ebx
	addl	-24(%ebp), %edi
	jmp	.L36
.L50:
	addl	$40, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	gauss_solve.constprop.2, .-gauss_solve.constprop.2
	.globl	grub_reed_solomon_recover
	.type	grub_reed_solomon_recover, @function
grub_reed_solomon_recover:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$64, %esp
	testl	%ecx, %ecx
	movl	%eax, -52(%ebp)
	movl	%edx, -24(%ebp)
	movl	%ecx, -44(%ebp)
	je	.L52
	movb	$0, 1049088
	movb	$1, %al
	xorl	%edx, %edx
.L58:
	movzbl	%al, %ecx
	testb	%al, %al
	movb	%al, 1048576(%edx)
	movb	%al, 1048831(%edx)
	movb	%dl, 1049088(%ecx)
	jns	.L54
	leal	(%ecx,%ecx), %eax
	xorl	$29, %eax
	jmp	.L55
.L54:
	addl	%eax, %eax
.L55:
	incl	%edx
	cmpl	$255, %edx
	jne	.L58
	movl	-52(%ebp), %eax
	addl	-24(%ebp), %eax
	movl	%eax, -56(%ebp)
.L57:
	cmpl	$0, -24(%ebp)
	je	.L52
	movl	-44(%ebp), %ecx
	addl	-24(%ebp), %ecx
	cmpl	$102400, %ecx
	jbe	.L94
	imull	$200, -24(%ebp), %eax
	xorl	%edx, %edx
	divl	%ecx
	xorl	%edx, %edx
	movl	%eax, -28(%ebp)
	imull	$200, -44(%ebp), %eax
	sall	$9, -28(%ebp)
	divl	%ecx
	movl	%eax, -36(%ebp)
	sall	$9, -36(%ebp)
	jmp	.L59
.L94:
	movl	-44(%ebp), %eax
	movl	%eax, -36(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, -28(%ebp)
.L59:
	movl	-28(%ebp), %eax
	movl	-52(%ebp), %esi
	leal	511(%eax), %ebx
	movl	%ebx, -40(%ebp)
	movl	-56(%ebp), %ebx
	leal	-1(%eax), %edi
	movl	%esi, -48(%ebp)
	movl	%edi, -64(%ebp)
	leal	511(%ebx,%eax), %eax
	movl	%eax, -72(%ebp)
.L91:
	movl	-40(%ebp), %ebx
	movl	%ebx, %eax
	shrl	$9, %eax
	movl	%eax, -20(%ebp)
	movl	-36(%ebp), %eax
	subl	-28(%ebp), %eax
	addl	%ebx, %eax
	shrl	$9, %eax
	movl	%eax, -16(%ebp)
	je	.L60
	xorl	%eax, %eax
	cmpl	$0, -20(%ebp)
	jne	.L61
.L60:
	decl	-40(%ebp)
	movl	-64(%ebp), %eax
	incl	-48(%ebp)
	cmpl	%eax, -40(%ebp)
	jne	.L91
	movl	-28(%ebp), %eax
	movl	-36(%ebp), %edi
	addl	%eax, -52(%ebp)
	addl	%edi, -56(%ebp)
	subl	%eax, -24(%ebp)
	subl	%edi, -44(%ebp)
	jmp	.L57
.L61:
	cmpl	-20(%ebp), %eax
	jge	.L97
	movl	-48(%ebp), %esi
	movl	%eax, %edx
	incl	%eax
	sall	$9, %edx
	movb	(%esi,%edx), %dl
	movb	%dl, 1052159(%eax)
	jmp	.L61
.L97:
	xorl	%eax, %eax
.L65:
	cmpl	-16(%ebp), %eax
	jge	.L98
	movl	-72(%ebp), %ecx
	movl	%eax, %edx
	incl	%eax
	subl	-40(%ebp), %ecx
	sall	$9, %edx
	movl	-20(%ebp), %edi
	movb	(%ecx,%edx), %dl
	movb	%dl, 1052159(%eax,%edi)
	jmp	.L65
.L98:
	movl	-16(%ebp), %eax
	xorl	%esi, %esi
	movl	-20(%ebp), %edi
	movl	%eax, %ebx
	shrl	%ebx
	leal	-1(%edi,%eax), %eax
	movl	%ebx, -32(%ebp)
	movl	%eax, -60(%ebp)
.L67:
	movl	-60(%ebp), %edx
	movl	%esi, %ecx
	movl	$1052160, %eax
	incl	%esi
	call	pol_evaluate
	movb	%al, 1051903(%esi)
	cmpl	-16(%ebp), %esi
	jl	.L67
	xorl	%eax, %eax
.L70:
	cmpb	$0, 1051904(%eax)
	jne	.L69
	incl	%eax
	cmpl	-16(%ebp), %eax
	jl	.L70
.L69:
	cmpl	-16(%ebp), %eax
	je	.L71
	movl	-32(%ebp), %eax
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	leal	1(%eax), %esi
	jmp	.L72
.L71:
	xorl	%eax, %eax
	jmp	.L73
.L77:
	movb	1051904(%eax,%edx), %bl
	incl	%eax
	movb	%bl, 1052671(%eax,%ecx)
	cmpl	%eax, -32(%ebp)
	jge	.L77
	incl	%edx
	addl	%esi, %ecx
.L72:
	xorl	%eax, %eax
	cmpl	-32(%ebp), %edx
	jl	.L77
.L76:
	cmpl	-32(%ebp), %eax
	jge	.L99
	movb	$0, 1050368(%eax)
	incl	%eax
	jmp	.L76
.L99:
	movl	-32(%ebp), %ebx
	movl	$1050368, %ecx
	xorl	%esi, %esi
	xorl	%edi, %edi
	movl	%ebx, %eax
	movl	%ebx, %edx
	call	gauss_solve.constprop.2
	movl	-16(%ebp), %eax
	decl	%ebx
	addl	-20(%ebp), %eax
	movl	%eax, -32(%ebp)
.L79:
	cmpl	-32(%ebp), %esi
	jge	.L100
	movl	$255, %ecx
	movl	%ebx, %edx
	subl	%esi, %ecx
	movl	$1050368, %eax
	call	pol_evaluate
	cmpb	1048576(%esi), %al
	jne	.L80
	movb	%al, 1050624(%edi)
	movl	-60(%ebp), %eax
	movl	%edi, %edx
	incl	%edi
	subl	%esi, %eax
	movl	%eax, 1050880(,%edx,4)
.L80:
	incl	%esi
	jmp	.L79
.L100:
	xorl	%eax, %eax
.L82:
	cmpl	%edi, %eax
	jge	.L101
	movb	$1, 1052672(%eax)
	incl	%eax
	jmp	.L82
.L101:
	movb	1051904, %al
	xorl	%esi, %esi
	movl	$1, %ecx
	movb	%al, 1052672(%edi)
	leal	1(%edi), %eax
	movl	%eax, -32(%ebp)
	movl	%eax, -68(%ebp)
.L84:
	cmpl	-16(%ebp), %ecx
	jge	.L86
	movl	-68(%ebp), %eax
	xorl	%ebx, %ebx
	addl	%esi, %eax
	movl	%eax, -60(%ebp)
.L87:
	cmpl	%edi, %ebx
	jge	.L102
	movl	%ecx, -76(%ebp)
	movzbl	1052672(%ebx,%esi), %edx
	incl	%ebx
	movzbl	1050623(%ebx), %eax
	call	gf_mul
	movl	-60(%ebp), %edx
	movb	%al, 1052671(%ebx,%edx)
	movl	-76(%ebp), %ecx
	jmp	.L87
.L102:
	movb	1051904(%ecx), %al
	incl	%ecx
	movb	%al, 1052673(%esi,%edi,2)
	addl	-32(%ebp), %esi
	jmp	.L84
.L86:
	movl	-16(%ebp), %eax
	movl	$1052416, %ecx
	movl	%edi, %edx
	call	gauss_solve.constprop.2
	xorl	%eax, %eax
.L88:
	cmpl	%edi, %eax
	jge	.L71
	movl	1050880(,%eax,4), %edx
	incl	%eax
	movb	1052415(%eax), %cl
	xorb	%cl, 1052160(%edx)
	jmp	.L88
.L73:
	movb	1052160(%eax), %dl
	movl	%eax, %ecx
	incl	%eax
	movl	-48(%ebp), %ebx
	sall	$9, %ecx
	cmpl	-20(%ebp), %eax
	movb	%dl, (%ebx,%ecx)
	jl	.L73
	jmp	.L60
.L52:
	addl	$64, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	grub_reed_solomon_recover, .-grub_reed_solomon_recover
	.ident	"GCC: (GNU) 4.8.1 20130530 (prerelease)"
	.section	.note.GNU-stack,"",@progbits
