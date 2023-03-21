type project = {
  title : string;
  number: string;
  description : string;
  mentee : string;
  blog : string option;
  source : string;
  mentors : string list;
  video : string option;
}
[@@deriving of_yaml, show { with_path = false }]

type metadata = { name : string; projects : project list }
[@@deriving of_yaml, show { with_path = false }]

type t = metadata [@@deriving of_yaml, show { with_path = false }]

let decode s =
  let yaml = Utils.decode_or_raise Yaml.of_string s in
  match yaml with
  | `O [ ("rounds", `A xs) ] ->
      Ok (List.map (Utils.decode_or_raise metadata_of_yaml) xs)
  | _ -> Error (`Msg "expected a list of outreachy rounds")

let all () =
  Utils.yaml_sequence_file ~key:"rounds" metadata_of_yaml "outreachy.yml"

let template () =
  Format.asprintf
    {|
type project =
  { title : string
  ; number: string
  ; description : string
  ; mentee : string
  ; blog : string option
  ; source : string
  ; mentors : string list
  ; video : string option
  }

type t =
  { name : string
  ; projects : project list
  }

let all = %a
|}
    (Fmt.brackets (Fmt.list pp ~sep:Fmt.semi))
    (all ())
