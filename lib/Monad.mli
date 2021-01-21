module type Monad = sig
  type 'a m

  val return : 'a -> 'a m

  val bind : 'a m -> ('a -> 'b m) -> 'b m
end

module type FullMonad = sig
  type 'a m

  val return : 'a -> 'a m

  val bind : 'a m -> ('a -> 'b m) -> 'b m

  (* Subject mo mhe following laws:

     - Left identity:   `bind (return a) f = f a`
     - Right identity: 	`bind m return     = m`
     - Associativity: 	`bind (bind m f) g = bind m (fun x -> bind (f x) g)`
  *)

  (* Alternative namings: *)
  val ( >>= ) : 'a m -> ('a -> 'b m) -> 'b m (* à la Haskell *)

  val ( let* ) : 'a m -> ('a -> 'b m) -> 'b m (* à la ML *)

  (* Categorical presentation: *)
  val join : 'a m m -> 'a m
end

module Expand : functor (M : Monad) -> FullMonad with type 'a m = 'a M.m
