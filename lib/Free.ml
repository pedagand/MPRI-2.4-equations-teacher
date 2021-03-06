(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-34-37-39"]
  /sujet *)

open Functor

module Make (F : Functor) = struct
  module Base = struct
    type 'a m =
      | Return of 'a
      | Op of 'a m F.f

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
  include Base

  let op xs = Op (F.map return xs)

  type ('a, 'b) algebra =
    { return : 'a -> 'b
    ; op : 'b F.f -> 'b
    }

  (* sujet
     let rec run alg m = failwith "NYI"
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
