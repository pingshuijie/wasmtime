;;! target = "x86_64"
;;! test = "winch"

(module
    (func (result i32)
        (f64.const 1.1)
        (f64.const 2.2)
        (f64.lt)
    )
)
;; wasm[0]::function[0]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movq    8(%rdi), %r11
;;       movq    0x10(%r11), %r11
;;       addq    $0x10, %r11
;;       cmpq    %rsp, %r11
;;       ja      0x54
;;   1c: movq    %rdi, %r14
;;       subq    $0x10, %rsp
;;       movq    %rdi, 8(%rsp)
;;       movq    %rsi, (%rsp)
;;       movsd   0x21(%rip), %xmm0
;;       movsd   0x21(%rip), %xmm1
;;       ucomisd %xmm1, %xmm0
;;       movl    $0, %eax
;;       seta    %al
;;       addq    $0x10, %rsp
;;       popq    %rbp
;;       retq
;;   54: ud2
;;   56: addb    %al, (%rax)
