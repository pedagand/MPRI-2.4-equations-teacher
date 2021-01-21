open Monoid

module Make (P : Monoid) (S : MonoidAction with type monoid = P.monoid) : sig
  include Monad.FullMonad

  (* Operations *)

  val get : unit -> S.action m

  val set : P.monoid -> unit m

  (* Subject to the following equations:
     [W1] let* () = set Log.empty in
          m
              ~
          m

     [W2] let* () = set p1 in
          let* () = set p2 in
          m
              ~
          let* () = set (p1 <+> p2) in
          m

     [R1] let* s = get () in m
              ~
          m

     [R2] let* s1 = get () in
          let* s2 = get () in
          k s1 s2
              ~
          let* s = get () in
          k s s

      [U] let* () = set p in
          let* s = get in
          k s
              ~
          let* s = get () in
          let* () = set p in
          k (S.act s p)
  *)

  (* Runner *)

  val run : 'a m -> S.action -> P.monoid * 'a
end
