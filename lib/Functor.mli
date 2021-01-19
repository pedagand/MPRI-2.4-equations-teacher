module type Pattern = sig
  type ('i, 'o) t
end

module Sum (P1 : Pattern) (P2 : Pattern) : sig
  type ('i, 'o) t =
    | Inl : ('i, 'o) P1.t -> ('i, 'o) t
    | Inr : ('i, 'o) P2.t -> ('i, 'o) t
  [@@warning "-34-37"]
end

module type Functor = sig
  type 'a t

  val map : ('a -> 'b) -> 'a t -> 'b t
end

module Make (P : Pattern) : sig
  type 'a t = Constr : ('i, 'o) P.t * 'i * ('o -> 'a) -> 'a t

  val map : ('a -> 'b) -> 'a t -> 'b t

  val constr : ('i, 'o) P.t -> 'i -> 'o t
end
