module type Pattern = sig
  type ('i, 'o) t
end

module Sum (P1 : Pattern) (P2 : Pattern) = struct
  type ('i, 'o) t =
    | Inl : ('i, 'o) P1.t -> ('i, 'o) t
    | Inr : ('i, 'o) P2.t -> ('i, 'o) t
  [@@warning "-34-37"]
end

module type Functor = sig
  type 'a t

  val map : ('a -> 'b) -> 'a t -> 'b t
end

module Make (P : Pattern) = struct
  type 'a t = Constr : ('i, 'o) P.t * 'i * ('o -> 'a) -> 'a t

  let map f xs =
    match xs with Constr (op, args, k) -> Constr (op, args, fun o -> f (k o))


  let constr p args = Constr (p, args, fun x -> x)
end
