open Eliom_lib
open Eliom_content
open Eliom_content.Html5.D

module Bookmark_app =
  Eliom_registration.App (
    struct
      let application_name = "bookmark"
    end)

module Bookmark_action = Eliom_registration.Action

let authenticated_handler f =
  let handle_anonymous _get _post =
    let lb = Document.login_box
      Services.authentication_service
      Services.registration_service
    in
    let title = "Please Authenticate" in
    let content = lb in
    Document.create_page title content
  in
  Eliom_tools.wrap_handler
    (fun () -> Session.get_user_id ())
    handle_anonymous (* username reference does not exist *)
    f (* username reference exist *)

let () =
  Bookmark_app.register
    ~service:Services.main_service
    (authenticated_handler
       (fun user_id _get _post ->
         Pages.index_page user_id)
    )

let () =
  Bookmark_action.register
    ~service:Services.authentication_service
    (fun () (username, password) ->
      Db.check_pwd username password >>=
        (function
        | true ->
          Db.find_by_name username >>=
            (function
            | [] -> raise (Failure "Incoherent data presented!")
            | u::_ -> Session.set_user_id (Int32.to_int (Sql.get u#id)))
        | false -> Lwt.return ()
        ))

let () =
  Bookmark_app.register
    ~service:Services.registration_service
    (fun () () ->
      Pages.registration_page
    )

let () =
  Bookmark_app.register
    ~service:Services.sign_up_service
    (fun () (username, password) ->
      let title = "Sign Up" in
      Db.find_by_name username >>=
        (function
        | [] ->
          Db.insert username password >>=
            (function () ->
              Db.find_by_name username >>=
                (function
                | [] ->
                  let content = [p [pcdata "Error Occured"]] in
                  Document.create_page title content
                | result::_ ->
                  let r_username = Sql.get result#username in
                  let content = (p [pcdata "Success!"])::
                    [p [pcdata "Welcome "; b [pcdata r_username]; pcdata "!"]]
                  in
                  Document.create_page title content
                ))
        | _ ->
          let content = [p [pcdata "Duplicated found!"]] in
          Document.create_page title content
    ))

let () = Bookmark_app.register
  ~service:Services.profile_service
  (authenticated_handler
     (fun user_id _get _post ->
       Pages.profile_page user_id
     )
  )

let () =
  Bookmark_app.register
    ~service:Services.change_pwd_service
    (fun () (id, (username, password)) ->
      let title = "Change Password" in
      Db.find_by_id (Int32.of_int id) >>=
        (function
        | [] ->
          let content = [p [pcdata "No such user"]] in
          Document.create_page title content
        | _ ->
          Db.change_pwd (Int32.of_int id) username password >>=
            (function () ->
             let content = [p [pcdata "Change Completed"]] in
             Document.create_page title content
            )
        )
    )
