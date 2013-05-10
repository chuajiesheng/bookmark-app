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
      let title = "Welcome" in
      let content = [p [pcdata "After Log in!"]] in
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
