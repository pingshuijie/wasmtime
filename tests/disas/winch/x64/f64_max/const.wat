;;! target = "x86_64"
;;! test = "winch"

(module
    (func (result f64)
        (f64.const 1.1)
        (f64.const 2.2)
        (f64.max)
    )
)
;; wasm[0]::function[0]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movq    8(%rdi), %r11
;;       movq    0x10(%r11), %r11
;;       addq    $0x10, %r11
;;       cmpq    %rsp, %r11
;;       ja      0x66
;;   1c: movq    %rdi, %r14
;;       subq    $0x10, %rsp
;;       movq    %rdi, 8(%rsp)
;;       movq    %rsi, (%rsp)
;;       movsd   0x31(%rip), %xmm0
;;       movsd   0x31(%rip), %xmm1
;;       ucomisd %xmm0, %xmm1
;;       jne     0x56
;;       jp      0x50
;;   47: andpd   %xmm0, %xmm1
;;       jmp     0x5a
;;   50: addsd   %xmm0, %xmm1
;;       jp      0x5a
;;   56: maxsd   %xmm0, %xmm1
;;       movaps  %xmm1, %xmm0
;;       addq    $0x10, %rsp
;;       popq    %rbp
;;       retq
;;   66: ud2
