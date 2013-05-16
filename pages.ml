open Eliom_content.Html5.D
open Lwt

let index_page user_id =
  let title = "Bookmark App" in
  lwt username = Db.get_username user_id in
  let content = [p [pcdata "Welcome "; pcdata username]] in
  Document.create_page title content

let registration_page =
  let title = "Register an Account" in
  let content =
        (p [pcdata "Please provide your registration details."])::
        [div (Document.sign_up_box Services.sign_up_service)]
  in
  Document.create_page title content

let profile_page user_id =
  let title = "Bookmark Profile and Settings" in
  lwt username = Db.get_username user_id in
  let content = [p [pcdata ("Change Profile and Settings for " ^ username)]] in
  Document.create_page title content
