open Functor
open Monad

module Make (F : Functor) : sig
  include FullMonad

  val op : 'a F.t -> 'a t

  type ('a, 'b) algebra =
    { return : 'a -> 'b
    ; op : 'b F.t -> 'b
    }

  val run : ('a, 'b) algebra -> 'a t -> 'b
end
