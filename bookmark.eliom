open Eliom_lib
open Eliom_content
open Eliom_content.Html5.D

module Bookmark_app =
  Eliom_registration.App (
    struct
      let application_name = "bookmark"
    end)

let () =
  Bookmark_app.register
    ~service:Services.main_service
    (fun () () ->
      let title = "Bookmark" in
      let content =
        (h2 [pcdata "Please log in."])::
        [div (Document.login_box
                Services.authentication_service
                Services.registration_service
        )]
      in
      Document.create_page title content
    )

let () =
  Bookmark_app.register
    ~service:Services.authentication_service
    (fun () (username, password) ->
      let result =
        Db.check_pwd username password
      in
      lwt message =
          result >>=
            (function
            | true -> Lwt.return (true)
            | false -> Lwt.return (false))
     in
    let title = "Welcome" in
      let content = match message with
          true -> (p [pcdata ("Welcome " ^ username)])::
            [div (Document.change_pwd_box Services.change_pwd_service)]
        | false -> [p [pcdata "Wrong username or password"]]
      in
      Document.create_page title content
    )

let () =
  Bookmark_app.register
    ~service:Services.registration_service
    (fun () () ->
      let title = "Registration" in
      let content =
        (p [pcdata "Please provide your registration details."])::
        [div (Document.sign_up_box Services.sign_up_service)]
      in
      Document.create_page title content
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

                )
            )
        | _ ->
          let content = [p [pcdata "Duplicated found!"]] in
          Document.create_page title content
    ))

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
