module type Monad = sig
  type 'a m

  val return : 'a -> 'a m

  val bind : 'a m -> ('a -> 'b m) -> 'b m
end

module type FullMonad = sig
  type 'a m

  val return : 'a -> 'a m

  val bind : 'a m -> ('a -> 'b m) -> 'b m

  (* Alternative namings: *)
  val ( >>= ) : 'a m -> ('a -> 'b m) -> 'b m (* à la Haskell *)

  val ( let* ) : 'a m -> ('a -> 'b m) -> 'b m (* à la ML *)

  (* Categorical presentation: *)
  val join : 'a m m -> 'a m
end

module Expand (M : Monad) = struct
  include M

  (* À la Haskell *)
  let ( >>= ) = M.bind

  (* À la ML *)
  let ( let* ) = M.bind

  (* Categorical presentation *)
  let join mmx = M.bind mmx (fun mx -> mx)
end
