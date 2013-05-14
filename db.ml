module Lwt_thread = struct
  include Lwt
  include Lwt_chan
end
module Lwt_PGOCaml = PGOCaml_generic.Make(Lwt_thread)
module Lwt_Query = Query.Make_with_Db(Lwt_thread)(Lwt_PGOCaml)
open Lwt

let get_db : unit -> unit Lwt_PGOCaml.t Lwt.t =
  let db_handler = ref None in
  fun () ->
    match !db_handler with
    | Some h -> Lwt.return h
    | None -> Lwt_PGOCaml.connect ~database:"bookmark" ()

(*
  create a seq as similar to postgresql
  see http://www.postgresql.org/docs/8.1/static/datatype.html#DATATYPE-SERIAL
  beside serial, bigserial also available
  serial is mapped to Sql.int32_t
  while bigserial is mapped to Sql.int64_t
*)
let users_id_seq = <:sequence< serial "users_id_seq">>

let users = <:table< users (
  id integer NOT NULL DEFAULT(nextval $users_id_seq$),
  username text NOT NULL,
  password text NOT NULL
) >>

let find_by_name name =
  (get_db () >>= fun dbh ->
   Lwt_Query.view dbh
   <:view< {id = user_.id; username = user_.username; password = user_.password} |
            user_ in $users$;
            user_.username = $string:name$; >>)

let find_by_id id =
  (get_db () >>= fun dbh ->
   Lwt_Query.view dbh
   <:view< {id = user_.id; username = user_.username; password = user_.password} |
            user_ in $users$;
            user_.id = $int32:id$; >>)

let check_pwd name pwd =
  (get_db () >>= fun dbh ->
   Lwt_Query.view dbh
   <:view< {password = user_.password} |
            user_ in $users$;
            user_.username = $string:name$;
    user_.password = $string:pwd$ >>)
  >|= (function [] -> false | _ -> true)

let insert name pwd =
  (get_db () >>= fun dbh ->
  Lwt_Query.query dbh
  <:insert< $users$ :=
    { id = nextval $users_id_seq$;
      username = $string:name$;
      password = $string:pwd$; } >>)

let change_pwd id name pwd =
  (get_db () >>= fun dbh ->
  Lwt_Query.query dbh
  <:update<
    u in $users$
    := { password = $string:pwd$ }
    | u.id = $int32:id$;
      u.username = $string:name$; >>
  )
