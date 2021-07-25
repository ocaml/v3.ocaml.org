let loader _root path _request =
  match Asset.read path with
  | None ->
    Dream.empty `Not_Found
  | Some asset ->
    Dream.respond asset

let package_routes =
  [ Dream.get "/packages" Package_handler.index
  ; Dream.get "/packages/" Package_handler.index
  ; Dream.get "/packages/search" Package_handler.search
  ; Dream.get "/p/:name" Package_handler.package
  ; Dream.get "/u/:hash/:name" Package_handler.package
  ; Dream.get
      "/p/:name/:version"
      (Package_handler.package_versioned Package_handler.Package)
  ; Dream.get
      "/u/:hash/:name/:version"
      (Package_handler.package_versioned Package_handler.Universe)
  ; Dream.get
      "/p/:name/:version/doc/**"
      (Package_handler.package_doc Package_handler.Package)
  ; Dream.get
      "/u/:hash/:name/:version/doc/**"
      (Package_handler.package_doc Package_handler.Universe)
  ; Dream.any "/graphql" (Dream.graphql Lwt.return Schema.schema)
  ; Dream.get
      "/graphiql"
      (Dream.graphiql ~default_query:Schema.default_query "/graphql")
  ; Dream.get "/assets/**" (Dream.static ~loader "")
  ]

let site_routes =
  [ Dream.get "/" (fun req ->
        (* Temporary solution for locales *)
        Dream.redirect req "/en/")
  ; Dream.get "/index.html" (fun req ->
        (* Temporary solution for locales *)
        Dream.redirect req "/en/")
  ; Dream.get "/**" (Dream.static Ocamlorg.site_dir)
  ]

let router = Dream.router (package_routes @ site_routes)
