include Monad.FullMonad

(* Operations *)

val err : exn -> 'a m

(* Runner *)

val run : 'a m -> 'a
