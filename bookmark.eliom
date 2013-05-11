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
        [div (Document.login_box Services.authentication_service Services.registration_service)]
      in
      Document.create_page title content
    )

let () =
  Bookmark_app.register
    ~service:Services.authentication_service
    (fun () (username, password) ->
      lwt message =
      Db.check_pwd username password >>=
        (function
        | true -> Lwt.return ("Hello " ^ username)
        | false -> Lwt.return ("Wrong username or password"))
     in
      let title = "Welcome" in
      let content = [p [pcdata message]] in
      Document.create_page title content
    )

let () =
  Bookmark_app.register
    ~service:Services.registration_service
    (fun () () ->
      let title = "Registration" in
      let content = [p [pcdata "Please provide your registration details."]] in
      Document.create_page title content
    )
