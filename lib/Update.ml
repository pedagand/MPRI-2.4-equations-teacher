open Monoid

(* sujet
(* Once you are done writing the code, remove this directive,
   whose purpose is to disable several warnings. *)
[@@@warning "-27-32-33-37-39"]
  /sujet *)



module Make (P : Monoid) (S : MonoidAction with type m = P.t) = struct
  module Reader = Reader.Make(struct type t = S.t end)
  module Writer = Writer.Make(P)

  (* sujet
  let lift ((l1, k): 'a Reader.t Writer.t): 'a Writer.t Reader.t = failwith "NYI"
     /sujet *)
  (* corrige *)
  let lift ((l1, k): 'a Reader.t Writer.t): 'a Writer.t Reader.t =
    fun s -> (l1, k (S.act s l1))
  (* /corrige *)

  module Base = struct
    type 'a t = 'a Writer.t Reader.t

    (* sujet
    let return a = failwith "NYI"

    let bind m f = failwith "NYI"
       /sujet *)

    (* corrige *)
    let return a = Reader.return (Writer.return a)

    let bind (rwm: 'a t)(f: 'a -> 'b t) =
      Reader.bind rwm (fun wm ->
          Reader.bind (lift (Writer.bind wm (fun v ->
                    Writer.return (f v)))) (fun rm ->
              Reader.return (Writer.join rm)))
    (* /corrige *)
  end

  module M = Monad.Expand (Base)
  include M
  open Base

  (* sujet
  let get () = failwith "NYI"
  let set s = failwith "NYI"
  let run m s0 = failwith "NYI"
     /sujet *)

  (* corrige *)
  let get () = Reader.bind (Reader.get ()) return

  let set s = lift (Writer.bind (Writer.set s) (fun _ ->
                        Writer.return (Reader.return ())))

  let run m s0 = Writer.run (Reader.run m s0)
  (* /corrige *)


end

(* Want more? [http://cs.ioc.ee/~tarmo/papers/types13.pdf] *)
