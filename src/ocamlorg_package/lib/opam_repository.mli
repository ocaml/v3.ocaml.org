val clone : unit -> unit Lwt.t
(** [clone ()] ensures that "./opam-repository" exists. If not, it clones it. *)

val pull : unit -> unit Lwt.t
(** Does a "git pull origin" to update the store. *)

val last_commit : unit -> string Lwt.t
(** Get the latest commit of the opam repository. *)

val list_packages : unit -> string list
(** List the packages in the [packages/] directory of the opam repository. *)

val list_package_versions : string -> string list
(** List the versions of the given package by reading the directories in the
    [packages/<package>/] directory *)

val opam_file : string -> string -> OpamFile.OPAM.t Lwt.t
(** Return the opam file structure given a package name and package version. *)

val commit_at_date : string -> string Lwt.t
(** Find the first commit that happened before or at a date. Will be passed to
    Git's [--before] option, for example ["30.days"]. *)

val new_files_since : a:string -> b:string -> Fpath.t list Lwt.t
(** Files created during a range of commit. *)
