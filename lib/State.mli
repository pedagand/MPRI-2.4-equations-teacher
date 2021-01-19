module Make (S : sig
  type t
end) : sig

  include Monad.FullMonad

  (* Operations *)

  val get : unit -> S.t t

  val set : S.t -> unit t

  (* Runner *)

  val run : 'a t -> S.t -> 'a
end
