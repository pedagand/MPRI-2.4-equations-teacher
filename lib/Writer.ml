(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)

module Make (Log : Monoid.Monoid) =
struct
  open Log

  module Base = struct
    type 'a m = Log.monoid * 'a

    (* sujet
       let return a = failwith "NYI"

       let bind m f = failwith "NYI"
          /sujet *)

    (* corrige *)
    let return x = (empty, x)

    let bind m f =
      let l1, r1 = m in
      let l2, r2 = f r1 in
      (l1 <+> l2, r2)

    (* /corrige *)
  end

  module M = Monad.Expand (Base)
  include M

  (* sujet
     let set l = failwith "NYI"

     let run m = failwith "NYI"
        /sujet *)

  (* corrige *)
  let set l = (l, ())

  let run m = m

  (* /corrige *)
end
