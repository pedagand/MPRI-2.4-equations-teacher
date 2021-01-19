(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

module Make (S : sig
  type t
end) =
struct
  (* sujet
     module Signature = struct
       type 'a t = | (* NYI *)
       let map f s = failwith "NYI"
     end
        /sujet *)

  (* corrige *)
  module Variant = struct
    type ('i, 'o) t =
      | Get : (unit, S.t) t
      | Set : (S.t, unit) t
  end

  module Signature = Functor.Make (Variant)
  open Signature

  (* corrige *)

  module State = Free.Make (Signature)
  include State

  (* sujet
     let get () = failwith "NYI"
     let set s = failwith "NYI"

     let run m = failwith "NYI"
        /sujet *)

  (* corrige *)
  let get () = op (Constr (Get, (), fun x -> x))

  let set s = op (Constr (Set, s, fun x -> x))

  let run m =
    let alg =
      { return = (fun a _ -> a)
      ; op =
          (function
          | Constr (Get, (), k) ->
              fun (s : S.t) -> k s s
          | Constr (Set, (s : S.t), k) ->
              fun _ -> k () s)
      }
    in
    State.run alg m

  (* /corrige *)
end
