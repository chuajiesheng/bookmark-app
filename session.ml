let _user_id =
  Eliom_reference.eref
    ~scope:Eliom_common.default_session_scope None

let get_user_id () =
  Eliom_reference.get _user_id

let set_user_id user_id =
  Eliom_reference.set _user_id (Some (string_of_int user_id))
