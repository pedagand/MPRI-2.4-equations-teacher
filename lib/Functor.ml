module type Pattern = sig
  type ('i, 'o) p
end

module Sum (P1 : Pattern) (P2 : Pattern) = struct
  type ('i, 'o) p =
    | Inl : ('i, 'o) P1.p -> ('i, 'o) p
    | Inr : ('i, 'o) P2.p -> ('i, 'o) p
  [@@warning "-34-37"]
end

module type Functor = sig
  type 'a f

  val map : ('a -> 'b) -> 'a f -> 'b f
end

module Make (P : Pattern) = struct
  type 'a f = Constr : ('i, 'o) P.p * 'i * ('o -> 'a) -> 'a f

  let map f xs =
    match xs with Constr (op, args, k) -> Constr (op, args, fun o -> f (k o))


  let constr p args = Constr (p, args, fun x -> x)
end
