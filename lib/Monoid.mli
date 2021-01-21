module type Monoid = sig
  type monoid

  val empty : monoid

  val ( <+> ) : monoid -> monoid -> monoid
end

module type MonoidAction = sig
  type monoid

  type action

  val act : action -> monoid -> action
end
