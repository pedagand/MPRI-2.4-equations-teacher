module Make (Env : sig
  type t
end) : sig
  include Monad.FullMonad with type 'a t = Env.t -> 'a

  (* Operations *)

  val get : unit -> Env.t t

  (* Subject to the following equations:
     [R1] let* s = get () in m
              ~
          m

     [R2] let* s1 = get () in
          let* s2 = get () in
          k s1 s2
              ~
          let* s = get () in
          k s s
  *)

  (* Runner *)

  val run : 'a t -> Env.t -> 'a
end
