open Eliom_content.Html5.D
open Lwt

let index_page user_id =
  let title = "Bookmark App" in
  lwt username = Db.get_username user_id in
  let content = [p [pcdata "Welcome "; pcdata username]] in
  Document.create_page title content
