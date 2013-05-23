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

let username_box username = [
  label ~a:[a_for username] [pcdata "Username: "];
  string_input ~input_type:`Text
    ~name:username ();
  br ();
]

let password_box password = [
  label ~a:[a_for password] [pcdata "Password: "];
  string_input ~input_type:`Password
    ~name:password ();
  br ();
]

let submit_button text = [
  string_input ~input_type:`Submit
  ~value:text ()
]

let login_box auth_service create_service =
  [post_form ~service:auth_service
      (fun (username, password) ->
        [fieldset [
            div (username_box username);
            div (password_box password);
            div (submit_button "Login");
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

let change_pwd_box change_pwd_service user_id user =
  [post_form ~service:change_pwd_service
      (fun (id, (username, password)) ->
        [fieldset
            [int_input ~input_type:`Hidden
                ~name:id
                ~value:user_id ();
             string_input ~input_type:`Hidden
               ~name:username
               ~value:user ();
             label ~a:[a_for password] [pcdata "Password: "];
             string_input ~input_type:`Password
               ~name:password ();
             br ();
             string_input ~input_type:`Submit
               ~value:"Change Profile" ()
            ]
        ]
      ) ();
  ]

let add_bookmark_box add_bookmark_service user_id =
  [post_form ~service:add_bookmark_service
      (fun (u_id, (name, url)) ->
      [fieldset
          [int_input ~input_type:`Hidden
              ~name:u_id
              ~value:user_id ();
           label ~a:[a_for name] [pcdata "Name: "];
           string_input ~input_type:`Text
             ~name:name ();
           br ();
           label ~a:[a_for url] [pcdata "URL: "];
           string_input ~input_type:`Text
             ~name:url ();
           br ();
           div (submit_button "Add URL");
          ]]) ();
  ]
