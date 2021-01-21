open Functor

module Make (F : Functor) : sig
  type 'a m =
    | Return of 'a
    | Op of 'a m F.f

  val return : 'a -> 'a m

  val bind : 'a m -> ('a -> 'b m) -> 'b m

  val ( >>= ) : 'a m -> ('a -> 'b m) -> 'b m

  val ( let* ) : 'a m -> ('a -> 'b m) -> 'b m

  val join : 'a m m -> 'a m


  val op : 'a F.f -> 'a m

  type ('a, 'b) algebra =
    { return : 'a -> 'b
    ; op : 'b F.f -> 'b
    }

  val run : ('a, 'b) algebra -> 'a m -> 'b
end
