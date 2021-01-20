(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

(* sujet
module Signature = struct
  type 'a t = | (* NYI *)
  let map f s = failwith "NYI"
end
 /sujet *)

(* corrige *)
module Variant = struct
  type void = |

  type ('i, 'o) t = Err : (exn, void) t
end

module Signature = Functor.Make (Variant)
open Signature

(* /corrige *)

module Error = Free.Make (Signature)
include Error

(* sujet
let err e = failwith "NYI"

let run m = failwith "NYI"
   /sujet *)

(* corrige *)
let err e =
  let* void = op (constr Err e) in
  match void with _ -> .


let run m =
  let alg =
    { return = (fun x -> x); op = (function Constr (Err, e, _) -> raise e) }
  in
  Error.run alg m

(* /corrige *)
