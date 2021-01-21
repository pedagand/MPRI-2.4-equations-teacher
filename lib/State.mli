module Make (S : sig
  type t
end) : sig
  include Monad.FullMonad

  (* Operations *)

  val get : unit -> S.t m

  val set : S.t -> unit m

  (* Runner *)

  val run : 'a m -> S.t -> 'a
end
