open Functor

module Make (F : Functor) : sig
  type 'a t =
    | Return of 'a
    | Op of 'a t F.t

  val return : 'a -> 'a t

  val bind : 'a t -> ('a -> 'b t) -> 'b t

  (* Alternative namings: *)
  val ( >>= ) : 'a t -> ('a -> 'b t) -> 'b t (* à la Haskell *)

  val ( let* ) : 'a t -> ('a -> 'b t) -> 'b t (* à la ML *)

  (* Categorical presentation: *)
  val join : 'a t t -> 'a t


  val op : 'a F.t -> 'a t

  type ('a, 'b) algebra =
    { return : 'a -> 'b
    ; op : 'b F.t -> 'b
    }

  val run : ('a, 'b) algebra -> 'a t -> 'b
end
