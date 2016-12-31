module OCaml402 = struct
  let ast_impl_magic_number = "Caml1999M016"
  let ast_intf_magic_number = "Caml1999N015"
  type tree =
    | Intf of OCamlFrontend402.Parsetree.signature
    | Impl of OCamlFrontend402.Parsetree.structure
end

module OCaml403 = struct
  let ast_impl_magic_number = "Caml1999M019"
  let ast_intf_magic_number = "Caml1999N018"
  type tree =
    | Intf of OCamlFrontend403.Parsetree.signature
    | Impl of OCamlFrontend403.Parsetree.structure
end

module OCaml404 = struct
  let ast_impl_magic_number = "Caml1999M020"
  let ast_intf_magic_number = "Caml1999N018"
  type tree =
    | Intf of OCamlFrontend404.Parsetree.signature
    | Impl of OCamlFrontend404.Parsetree.structure
end

type tree =
  | OCaml402 of OCaml402.tree
  | OCaml403 of OCaml403.tree
  | OCaml404 of OCaml404.tree

type migration_error = [
  | `Pexp_letexception (* 4.04 -> 4.03: let exception _ in ... *)
  | `Ppat_open (* 4.04 -> 4.03: match x with M.(_) -> ... *)

  | `Pexp_unreachable
  | `PSig
  | `Pcstr_record
  | `Pconst_integer
  | `Pconst_float
]

exception Migration_error of migration_error

let migration_error error =
  raise (Migration_error error)

let migration_error_message = function
  | `Pexp_letexception -> "4.04 -> 4.03: Pexp_letexception"
  | `Ppat_open         -> "4.04 -> 4.03: Ppat_open"
  | `Pexp_unreachable  -> "4.03 -> 4.02: Pexp_unreachable"
  | `PSig              -> "4.03 -> 4.02: PSig"
  | `Pcstr_record      -> "4.03 -> 4.02: Pcstr_record"
  | `Pconst_integer    -> "4.03 -> 4.02: Pconst_integer"
  | `Pconst_float      -> "4.03 -> 4.02: Pconst_float"
