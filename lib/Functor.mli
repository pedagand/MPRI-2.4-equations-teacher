module type Pattern = sig
  type ('i, 'o) p
end

module Sum (P1 : Pattern) (P2 : Pattern) : sig
  type ('i, 'o) p =
    | Inl : ('i, 'o) P1.p -> ('i, 'o) p
    | Inr : ('i, 'o) P2.p -> ('i, 'o) p
  [@@warning "-34-37"]
end

module type Functor = sig
  type 'a f

  val map : ('a -> 'b) -> 'a f -> 'b f
end

module Make (P : Pattern) : sig
  type 'a f = Constr : ('i, 'o) P.p * 'i * ('o -> 'a) -> 'a f

  val map : ('a -> 'b) -> 'a f -> 'b f

  val constr : ('i, 'o) P.p -> 'i -> 'o f
end
