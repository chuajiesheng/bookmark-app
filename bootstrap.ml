open Eliom_content.Html5.D

(*
  Abbreviation for class name of the "bootstrap" v2 css
  The current set of class mapping are in sequence with the documentation
  @ http://twitter.github.io/bootstrap/
*)

(* ----- Scaffolding: Grid System  ----- *)
let row = a_class ["row"]
let span col = a_class ["span" ^ (string_of_int) col]
let offset col = a_class ["offset" ^ (string_of_int) col]
let row_fluid = a_class ["row-fluid"]
let container = a_class ["container"]
let container_fluid = a_class ["container-fluid"]

let row_t fluid = match fluid with
  | true -> row_fluid
  | false -> row

let container_t fluid = match fluid with
  | true -> container_fluid
  | false -> container

(* ----- Scaffolding: Responsive Design ----- *)
let visible_phone = a_class ["visible-phone"]
let visible_tablet = a_class ["visible-tablet"]
let visible_desktop = a_class ["visible-desktop"]

let hidden_phone = a_class ["hidden-phone"]
let hidden_tablet = a_class ["hidden-tablet"]
let hidden_desktop = a_class ["hidden-desktop"]

let phone_t visible = match visible with
  | true -> visible_phone
  | false -> hidden_phone

let tablet_t visible = match visible with
  | true -> visible_tablet
  | false -> hidden_tablet

let desktop_t visible = match visible with
  | true -> visible_desktop
  | false -> hidden_desktop

(* ----- Base CSS: Typography ----- *)
let lead = a_class ["lead"]
let text_left = a_class ["text-left"]
let text_center = a_class ["text-center"]
let text_right = a_class ["text-right"]

let muted = a_class ["muted"]
let text_warning = a_class ["text-warning"]
let text_error = a_class ["text-error"]
let text_info = a_class ["text-info"]
let text_success = a_class ["text_success"]

let initialism = a_class ["initialism"]
let pull_right = a_class ["pull-right"]

let unstyled = a_class ["unstyled"]
let inline = a_class ["inline"]
let dl_horizontal = a_class ["dl_horizontal"]

(* ----- Base CSS: Code ----- *)
let pre_scrollable = a_class ["pre-scrollable"]

(* ----- Base CSS: Tables ----- *)
let table = a_class ["table"]
let table_striped = a_class ["table-striped"]
let table_bordered = a_class ["table-bordered"]
let table_hover = a_class ["table-hover"]
let table_condensed = a_class ["table-condensed"]

let success = a_class ["success"]
let error = a_class ["error"]
let warning = a_class ["warning"]
let info = a_class ["info"]

(* ----- Base CSS: Forms ----- *)
let help_block = a_class ["help-block"]
let help_inline = a_class ["help-inline"]

let checkbox = a_class ["checkbox"]

let search_query = a_class ["search-query"]

let controls = a_class ["controls"]
let control_group = a_class ["control-group"]
let control_label = a_class ["control_label"]

let form_search = a_class ["form-search"]
let form_inline = a_class ["form-inline"]
let form_horizontal = a_class ["form-horizontal"]
let form_actions = a_class ["form-actions"]

let input_mini = a_class ["input-mini"]
let input_small = a_class ["input-small"]
let input_medium = a_class ["input-medium"]
let input_large = a_class ["input-large"]
let input_xlarge = a_class ["input-xlarge"]
let input_xxlarge = a_class ["input-xxlarge"]

let input_prepend = a_class ["input-prepend"]
let input_append = a_class ["input-append"]
let input_block_level = a_class ["input-block-level"]
let add_on = a_class ["add-on"]
let uneditable_input = a_class ["uneditable-input"]

let dropdown_menu = a_class ["dropdown-menu"]
let dropdown_toggle = a_class ["dropdown-toggle"]

let controls = a_class ["controls"]
let controls_row = a_class ["controls-row"]

let caret = a_class ["caret"]
let divider = a_class ["divider"]
let active = a_class ["active"]
let add_on = a_class ["add-on"]

(* ----- Base CSS: Buttons ----- *)
let btn_toolbar = a_class ["btn-toolbar"]
let btn_group = a_class ["btn-group"]
let btn_block = a_class ["btn-block"]

let btn_mini = a_class ["btn-mini"]
let btn = a_class ["btn"]
let btn_small = a_class ["btn-small"]
let btn_large = a_class ["btn-large"]

let btn_primary = a_class ["btn-primary"]
let btn_info = a_class ["btn-info"]
let btn_success = a_class ["btn-success"]
let btn_warning = a_class ["btn-warning"]
let btn_danger = a_class ["btn-danger"]
let btn_inverse = a_class ["btn-inverse"]
let btn_link = a_class ["btn-link"]

(* ----- Base CSS: Images ----- *)
let img_rounded = a_class ["img-rounded"]
let img_circle = a_class ["img-circle"]
let img_polaroid = a_class ["img-polaroid"]

(* ----- Base CSS: Icons ----- *)
let icon name = a_class ["icon-" ^ name]
let icon_white = a_class ["icon-white"]
let icon_envelope = a_class ["icon-envelope"]

let navbar = a_class ["navbar"]
let navbar_fixed_top = a_class ["navbar-fixed-top"]
let nav = a_class ["nav"]
let container = a_class ["container"]
let navbar_inner = a_class ["navbar-inner"]
let brand = a_class ["brand"]
let hero_unit = a_class ["hero-unit"]
let active = a_class ["active"]
