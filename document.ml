open Eliom_content.Html5.D

(*
  -important-
  the last element that is to be append to the list
  need to be in [] while the middle section element
  must be in ()

  example: ()::()::()::[]
  wrong example: ()::[]::()::()

  the last element must be a list that why the []
*)
let create_page mytitle mycontent =
  Lwt.return
    (html
       (head (title (pcdata mytitle)) [])
       (body ((h1 [pcdata mytitle])::mycontent)))

let login_box auth_service create_service =
  [post_form ~service:auth_service
      (fun (username, password) ->
        [fieldset
            [label ~a:[a_for username] [pcdata "Username: "];
             string_input ~input_type:`Text
               ~name:username ();
             br ();
             label ~a:[a_for password] [pcdata "Password: "];
             string_input ~input_type:`Password
               ~name:password ();
             br ();
             string_input ~input_type:`Submit
               ~value:"Login" ()
            ]]) ();
   p [a create_service
         [pcdata "Create an account"] ()]
  ]

let sign_up_box sign_up_service =
  [post_form ~service:sign_up_service
      (fun (username, password) ->
        [fieldset
            [label ~a:[a_for username] [pcdata "Preferred Username: "];
             string_input ~input_type:`Text
               ~name:username ();
             br ();
             label ~a:[a_for password] [pcdata "Password: "];
             string_input ~input_type:`Password
               ~name:password ();
             br ();
             string_input ~input_type:`Submit
               ~value:"Sign Up" ()
            ]]) ();
  ]
