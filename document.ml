open Eliom_content.Html5.D

let static s = make_uri ~service:(Eliom_service.static_dir ()) s

let navbar =
  let page_title = "Bookmark!" in
  div ~a:[Bootstrap.navbar] [
    div ~a:[Bootstrap.navbar_inner] [
      div ~a:[Bootstrap.container] [
        a ~a:[Bootstrap.brand]
          ~service:Eliom_service.void_coservice'
          ~fragment:"" [pcdata page_title] ();
        ul ~a:[Bootstrap.nav] [
          li [a ~service:Services.main_service [pcdata "Home"] ()];
          li [a ~service:Services.profile_service [pcdata "Profile"] ()];
          li [a ~service:Services.bookmark_service [pcdata "Manage"] ()];];]]]

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
       (head (title (pcdata mytitle))
          [css_link (static ["css";"bootstrap.css"]) ()])
       (body ((navbar)::mycontent)))

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

let hidden_int_input var value  =
  int_input ~input_type:`Hidden
    ~name:var
    ~value:value ()

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
      (fun (id, (username, (password, confirm_password))) ->
        let p1 = string_input ~input_type:`Password
               ~name:password () in
        let p2 = string_input ~input_type:`Password
          ~name:confirm_password () in
        let msg = div ~a:[a_id "message"] [pcdata ""] in
        [fieldset
            [hidden_int_input id user_id;
             string_input ~input_type:`Hidden
               ~name:username
               ~value:user ();
             label ~a:[a_for password] [pcdata "Password: "];
             p1;
             br ();
             label ~a:[a_for password] [pcdata "Confirm Password: "];
             p2;
             br ();
             string_input ~input_type:`Submit
               ~value:"Change Profile" ();
             br ();
             msg
            ]
        ]
      ) ();
  ]

let add_bookmark_box add_bookmark_service user_id =
  [post_form ~service:add_bookmark_service
      (fun (u_id, (name, url)) ->
      [fieldset
          [hidden_int_input u_id user_id;
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

let rec bookmarks_list list =
  let a name url =
    Raw.a
      ~a:[a_href (Raw.uri_of_string url)]
      [pcdata name]
  in
  let delete_bookmark user_id bookmark_id =
    [post_form ~service:Services.delete_bookmark_service
      (fun (u_id, b_id) ->
        [fieldset
            [hidden_int_input u_id (Int32.to_int user_id);
             hidden_int_input b_id (Int32.to_int bookmark_id);
             div (submit_button "Delete Bookmark");
            ]]) ();
    ]
  in
  let link name url =
    [a name url] in
  let delete_link user_id bookmark_id =
    [div (delete_bookmark user_id bookmark_id)] in
  match list with
    | [] -> []
    | head::tail ->
      (link (Sql.get head#name) (Sql.get head#url))
      @(delete_link (Sql.get head#user_id) (Sql.get head#id))
      @[br ();]
      @(bookmarks_list tail)
