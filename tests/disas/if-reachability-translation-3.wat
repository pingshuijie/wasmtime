;;! target = "x86_64"

;; Reachable `if` head and consequent and unreachable alternative means that the
;; following block is also reachable.

(module
  (func (param i32) (result i32)
    local.get 0
    if
      nop
    else
      unreachable
    end
    i32.const 0))

;; function u0:0(i64 vmctx, i64, i32) -> i32 tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i32):
;; @001f                               trapz v2, user11
;; @001b                               jump block2
;;
;;                                 block2:
;;                                     jump block3
;;
;;                                 block3:
;; @0021                               v4 = iconst.i32 0
;; @0023                               jump block1
;;
;;                                 block1:
;; @0023                               return v4  ; v4 = 0
;; }
