let rec read_newline icon =
  print_string icon;
  match read_line () with
  | exception End_of_file -> ()
  | input -> execute_input input

and raise_exn str =
  print_endline ("Error: " ^ str);
  read_newline "> "

and execute_input str =
  let args = String.split_on_char ' ' str in
  match args with
  | h :: t when h = "quit" || h = "exit" ->
      print_endline "See ya next time!"
  | h :: t when h = "help" ->
      print_endline "HELP IS HERE";
      read_newline "> "
  | h :: t when h = "let" -> execute_let_expr t
  | _ -> print_endline "bye"

and execute_let_expr args =
  print_endline "execute let expr";

  match args with
  | var :: delim :: expr ->
      print_endline var;
      print_endline delim;
      execute_expr expr;
      read_newline "> "
  | _ -> raise_exn "Invalid let expr"

and execute_expr expr =
  match expr with
  | call :: args -> (
      let call_arr = String.split_on_char '.' call in
      match call_arr with
      | [ m; fn ] -> execute_call m fn args
      | _ -> raise_exn "Invalid expr call")
  | _ -> raise_exn "Invalid expr"

and execute_call m fn args =
  match m with
  | "Dataframe" -> execute_df fn args
  | _ -> failwith "unimplemented"

and execute_df fn args =
  match fn with
  | "loadfile" -> print_endline "success"
  | _ -> failwith "unimplemented"

let main () =
  ANSITerminal.print_string [ ANSITerminal.cyan ]
    "\n\n Welcome to the OCAML Data Science CLI.\n\n";
  print_endline "INCLUDE INSTRUCTIONSSSS\n";
  read_newline "> "

(* Execute the game engine. *)
let () = main ()
