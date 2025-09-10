;; -----------------------------------------------------
;; STX Rainmaker
;; - Users register to join the rain
;; - Owner funds the contract with STX
;; - Owner calls "rain" to split funds equally among all users
;; -----------------------------------------------------

(define-constant ERR-NOT-OWNER (err u100))
(define-constant ERR-NO-USERS (err u101))
(define-constant ERR-EMPTY (err u102))

(define-data-var owner principal tx-sender)
(define-data-var total-users uint u0)

(define-map users
  { id: uint }
  { addr: principal })

;; Register a user (anyone can join once)
(define-public (register)
  (let ((id (+ u1 (var-get total-users))))
    (var-set total-users id)
    (map-set users { id: id } { addr: tx-sender })
    (ok id)))

;; Owner deposits STX for the rain
(define-public (fund (amount uint))
  (begin
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    (ok amount)))

;; Owner makes it rain: split funds equally among all users
(define-public (rain)
  (if (is-eq tx-sender (var-get owner))
      (let (
            (n (var-get total-users))
            (bal (stx-get-balance (as-contract tx-sender)))
           )
        (if (is-eq n u0)
            ERR-NO-USERS
            (if (is-eq bal u0)
                ERR-EMPTY
                (let ((share (/ bal n)))
                  (ok share)))))
      ERR-NOT-OWNER))

;; View total users
(define-read-only (get-total-users)
  (ok (var-get total-users)))
