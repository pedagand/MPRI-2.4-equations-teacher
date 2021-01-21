module Make (Log : Monoid.Monoid) : sig
  include Monad.FullMonad with type 'a m = Log.monoid * 'a

  (* Operations *)

  val set : Log.monoid -> unit m

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

  val run : 'a m -> Log.monoid * 'a
end
