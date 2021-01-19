open Functor

module Make (F : Functor) = struct
  module Base = struct
    type 'a t =
      | Return of 'a
      | Op of 'a t F.t

    (* sujet
       let return a = failwith "NYI"

       let rec bind m f = failwith "NYI"
         /sujet *)

    (* corrige *)
    let return a = Return a

    let rec bind m f =
      match m with
      | Return a ->
          f a
      | Op xs ->
          Op (F.map (fun m -> bind m f) xs)

    (* /corrige *)
  end

  module M = Monad.Expand (Base)
  include M
  open Base

  let op xs = Op (F.map return xs)

  type ('a, 'b) algebra =
    { return : 'a -> 'b
    ; op : 'b F.t -> 'b
    }

  (* sujet
     let rec run f alg m = failwith "NYI"
        /sujet *)
  (* corrige *)
  let rec run alg m =
    match m with
    | Return a ->
        alg.return a
    | Op xs ->
        alg.op (F.map (run alg) xs)

  (* /corrige *)
end
