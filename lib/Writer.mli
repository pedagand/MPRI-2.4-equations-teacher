module Make (Log : sig
  type t

  val empty : t

  val ( <+> ) : t -> t -> t
end) : sig

  include Monad.FullMonad with type 'a t = Log.t * 'a

  (* Operations *)

  val set : Log.t -> unit t

  (* Subject to the following equations:
  [W0] let* () = set Log.empty in
       m
           ~
       m

  [W1] let* () = set p1 in
       let* () = set p2 in
       m
           ~
       let* () = set (p1 <+> p2) in
       m
   *)

  (* Runner *)

  val run : 'a t -> Log.t * 'a
end
