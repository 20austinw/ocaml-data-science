type dataframe = { header : string list; data : string list list; }

val loadfile : string -> dataframe

val save_df : dataframe -> string -> unit 

val print_df : dataframe -> unit

val encode : string list -> float list

val cols_to_float : dataframe -> float list list

val pre_process : dataframe -> dataframe

val select_cols : dataframe -> string list -> dataframe

val select_cols_i : dataframe -> int list -> dataframe

val update: dataframe -> string -> (string -> bool) -> string -> dataframe

val update_i : dataframe -> int -> (string -> bool) -> string -> dataframe

val filter : dataframe -> string -> (string -> bool) -> dataframe

val filter_i : dataframe -> int -> (string -> bool) -> dataframe 

val train_test_split :
  dataframe -> string list -> string ->
  float -> float list list * float list list * float list * float list

val split_with_cross_val :
  dataframe -> string list -> string -> float -> float ->
  float list list * float list list * float list list * float list * float list * float list