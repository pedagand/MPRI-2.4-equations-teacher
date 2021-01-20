(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-34-37-39"]
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

  (* /corrige *)

  module FreeState = Free.Make (Signature)
  include FreeState

  (* Define [Signature] so that ['a FreeState.t] is isomorphic to the
          following type:

     <<<
          type 'a t =
            | Return of 'a
            | Get of unit * (S.t -> 'a t)
            | Set of S.t * (unit -> 'a t)
     >>>
  *)

  (* sujet
     let get () = failwith "NYI"
     let set s = failwith "NYI"

     let run m = failwith "NYI"
     /sujet *)

  (* corrige *)
  let get () = op (constr Get ())

  let set s = op (constr Set s)

  type exists = | Ex : 'a Signature.t -> exists

  exception Done
  module type Sigma = sig
    type fst 
    val snd : S.t -> fst
  end
  exception Continue of (module Sigma)

  let run (type a) (m: a t) s0 =
    let rec trampoline (m: a t)(s: S.t) =
      try
        match m with
        | Return a -> a
        | Op (Constr (Get, (), k)) -> 
           let module M = struct
               type fst = a
               let snd = (fun s -> trampoline (k s) s)
             end
           in 
           raise (Continue (module M))
        (* fun (s : S.t) -> k s s *)
        | Op (Constr (Set, (s : S.t), k)) -> 
           let module M = struct
               type fst = a
               let snd = (fun _ -> trampoline (k ()) s)
             end
           in
           raise (Continue (module M))
      with
      | Continue (module M) -> M.snd s
         
    in
    trampoline m s0

  (* /corrige *)
end
