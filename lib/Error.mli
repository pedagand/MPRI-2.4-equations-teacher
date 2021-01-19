include Monad.FullMonad

(* Operations *)

val err : exn -> 'a t

(* Runner *)

val run : 'a t -> 'a
