;;! target = "aarch64"
;;! test = "winch"
;;! flags = "-O static-memory-maximum-size=0 -O dynamic-memory-guard-size=0xffff"

(module
  (memory (export "memory") 1)
  (func (export "run") (param i32 i32 i32 i32)
    ;; Within the guard region.
    local.get 0
    local.get 1
    i32.store offset=0
    ;; Also within the guard region, bounds check should GVN with previous.
    local.get 0
    local.get 2
    i32.store offset=4
    ;; Outside the guard region, needs additional bounds checks.
    local.get 0
    local.get 3
    i32.store offset=0x000fffff
  )
)
;; wasm[0]::function[0]:
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       str     x28, [sp, #-0x10]!
;;       mov     x28, sp
;;       ldur    x16, [x0, #8]
;;       ldur    x16, [x16, #0x10]
;;       mov     x17, #0
;;       movk    x17, #0x20
;;       add     x16, x16, x17
;;       cmp     sp, x16
;;       b.lo    #0x124
;;   2c: mov     x9, x0
;;       sub     x28, x28, #0x20
;;       mov     sp, x28
;;       stur    x0, [x28, #0x18]
;;       stur    x1, [x28, #0x10]
;;       stur    w2, [x28, #0xc]
;;       stur    w3, [x28, #8]
;;       stur    w4, [x28, #4]
;;       stur    w5, [x28]
;;       ldur    w0, [x28, #8]
;;       ldur    w1, [x28, #0xc]
;;       ldur    x2, [x9, #0x40]
;;       mov     w3, w1
;;       adds    x3, x3, #4
;;       b.hs    #0x128
;;   68: cmp     x3, x2, uxtx
;;       b.hi    #0x12c
;;   70: ldur    x4, [x9, #0x38]
;;       add     x4, x4, x1, uxtx
;;       mov     x5, #0
;;       cmp     x3, x2, uxtx
;;       csel    x4, x5, x4, hi
;;       stur    w0, [x4]
;;       ldur    w0, [x28, #4]
;;       ldur    w1, [x28, #0xc]
;;       ldur    x2, [x9, #0x40]
;;       mov     w3, w1
;;       adds    x3, x3, #8
;;       b.hs    #0x130
;;   a0: cmp     x3, x2, uxtx
;;       b.hi    #0x134
;;   a8: ldur    x4, [x9, #0x38]
;;       add     x4, x4, x1, uxtx
;;       add     x4, x4, #4
;;       mov     x5, #0
;;       cmp     x3, x2, uxtx
;;       csel    x4, x5, x4, hi
;;       stur    w0, [x4]
;;       ldur    w0, [x28]
;;       ldur    w1, [x28, #0xc]
;;       ldur    x2, [x9, #0x40]
;;       mov     w3, w1
;;       mov     w16, #3
;;       movk    w16, #0x10, lsl #16
;;       adds    x3, x3, x16, uxtx
;;       b.hs    #0x138
;;   e4: cmp     x3, x2, uxtx
;;       b.hi    #0x13c
;;   ec: ldur    x4, [x9, #0x38]
;;       add     x4, x4, x1, uxtx
;;       orr     x16, xzr, #0xfffff
;;       add     x4, x4, x16, uxtx
;;       mov     x5, #0
;;       cmp     x3, x2, uxtx
;;       csel    x4, x5, x4, hi
;;       stur    w0, [x4]
;;       add     x28, x28, #0x20
;;       mov     sp, x28
;;       mov     sp, x28
;;       ldr     x28, [sp], #0x10
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;  124: .byte   0x1f, 0xc1, 0x00, 0x00
;;  128: .byte   0x1f, 0xc1, 0x00, 0x00
;;  12c: .byte   0x1f, 0xc1, 0x00, 0x00
;;  130: .byte   0x1f, 0xc1, 0x00, 0x00
;;  134: .byte   0x1f, 0xc1, 0x00, 0x00
;;  138: .byte   0x1f, 0xc1, 0x00, 0x00
;;  13c: .byte   0x1f, 0xc1, 0x00, 0x00
