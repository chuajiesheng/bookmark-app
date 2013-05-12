let main_service =
  Eliom_service.service ~path:[""] ~get_params:Eliom_parameter.unit ()

let authentication_service =
  Eliom_service.post_coservice'
    ~post_params:Eliom_parameter.(string "username" ** string "password")
    ()

let registration_service =
  Eliom_service.service ~path:["register"] ~get_params:Eliom_parameter.unit ()

let sign_up_service =
  Eliom_service.post_coservice'
    ~post_params:Eliom_parameter.(string "username" ** string "password")
    ()
