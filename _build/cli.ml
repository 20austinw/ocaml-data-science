let file_error_msg =
  "\nSorry, could not find the file. Please try again: \n\n"

let command_error_msg =
  "\nCould not execute command command. Please try again. \n\n"

let farewell_msg = "\nThank you!\n\n"

let print_red = ANSITerminal.print_string [ ANSITerminal.red ]

let print_blue = ANSITerminal.print_string [ ANSITerminal.blue ]

let print_magenta = ANSITerminal.print_string [ ANSITerminal.magenta ]

let print_green = ANSITerminal.print_string [ ANSITerminal.green ]

let print_init_instr () =
  print_string
    "Choose a number: (Eg. If you want to impute values, enter 1) \n";
  print_blue "1. Impute values\n";
  print_blue "2. Split dataset into training and test sets\n"

let print_model_choice () =
  print_string
    "\n\
     Choose a machine learning algorithm: (Eg. If you want logistic \
     regression, enter 1) ";
  print_blue "\n1. Logistic Regression";
  print_blue "\n2. Polynomial Regression";
  print_blue "\n3. K Nearest Neighbors";
  print_blue "\n4. K Means";
  print_blue "\n5. Naive Bayes";
  print_blue "\n6. Perceptron";
  print_blue "\n7. Decision Tree"

let rec handle_impute file input_func =
  print_string
    "Enter the name of the column you want to impute values for: ";
  let col = read_line () in
  match col with
  | "quit" ->
      print_magenta farewell_msg;
      exit 0
  | col_name -> (
      try
        print_string
          "Enter the value in this column that you like to replace: ";
        let update_what = read_line () in
        print_string
          "Enter the value that you would like to replace the previous \
           value: ";
        let update_with = read_line () in
        let file_updated =
          Dataframe.update file col_name
            (fun x -> x = update_what)
            update_with
        in
        print_green
          "Value succesfully imputed! The resulting dataset is: \n";
        Dataframe.print_df file_updated;
        input_func file_updated
      with _ ->
        print_red command_error_msg;
        handle_impute file input_func)

(* Call the relevant fit and predict functions in branches here, need to
   make them consistent across all algorithms first. *)
let rec choose_model x_train x_test y_train y_test =
  print_model_choice ();
  print_string "\n> ";
  let user_input = read_line () in

  let x_train_mat = Matrix.construct x_train in
  let x_test_mat = Matrix.construct x_test in
  let y_train_mat =
    [ y_train ] |> Matrix.construct |> Matrix.transpose
  in

  match user_input with
  | "quit" ->
      print_magenta farewell_msg;
      exit 0
  | "1" ->
      execute_log_regression x_train_mat x_test_mat y_train_mat y_test
  | "2" ->
      execute_poly_regression x_train_mat x_test_mat y_train_mat y_test
  | "3" -> ()
  | "4" -> ()
  | "5" -> ()
  | "6" -> ()
  | "7" -> ()
  | _ ->
      print_red command_error_msg;
      choose_model x_train x_test y_train y_test

and execute_log_regression x_train x_test y_train y_test =
  let w = Logistic_regression.fit x_train y_train 0.1 1000 in

  let y_pred =
    Logistic_regression.predict x_test
    |> Matrix.transpose |> Matrix.matrix |> List.hd
  in
  let acc = Utils.accuracy y_test y_pred in
  let mse = Utils.mean_squared_error y_test y_pred in
  print_endline ("Accuracy: " ^ string_of_float acc);
  print_endline ("Mean-Squared Error: " ^ string_of_float mse);
  ()

and execute_poly_regression x_train x_test y_train y_test =
  let w = Polynomial_regression.fit x_train y_train 10 in

  let y_pred =
    Polynomial_regression.predict x_test
    |> Matrix.transpose |> Matrix.matrix |> List.hd
  in
  let acc = Utils.accuracy y_test y_pred in
  let mse = Utils.mean_squared_error y_test y_pred in
  print_endline ("Accuracy: " ^ string_of_float acc);
  print_endline ("Mean-Squared Error: " ^ string_of_float mse);
  ()

let rec split_file file =
  print_string
    "\n\
     Enter the feature columns, one after another, separated by a \
     space: \n";
  let input_string = read_line () in
  let cols = String.split_on_char ' ' input_string in
  print_string "\nEnter the target column: \n";
  let target = read_line () in
  print_string "\nEnter the test percent: \n";
  let test_percent = read_line () in
  try
    let x_train, x_test, y_train, y_test =
      Dataframe.train_test_split file cols target
        (float_of_string test_percent)
    in
    choose_model x_train x_test y_train y_test
  with _ ->
    print_red command_error_msg;
    Dataframe.print_df file;
    split_file file

let rec ask_input file =
  print_init_instr ();
  print_string "> ";
  let user_input = read_line () in
  match user_input with
  | "1" -> handle_impute file ask_input
  | "2" -> split_file file
  | "quit" ->
      print_magenta farewell_msg;
      exit 0
  | _ ->
      print_red command_error_msg;
      ask_input file

let rec start_ui () =
  print_string
    "Please enter the name of the csv file you want to load, or ";
  print_red "quit\n";
  print_string "> ";
  match read_line () with
  | "quit" ->
      print_magenta "Thank you!\n";
      exit 0
  | exception End_of_file ->
      print_red file_error_msg;
      start_ui ()
  | file_name -> (
      try
        print_endline "";
        let file = Dataframe.loadfile file_name in
        Dataframe.print_df file;
        ask_input file
      with _ ->
        print_red file_error_msg;
        start_ui ())

let main () =
  ANSITerminal.erase Screen;
  print_blue "\nWelcome to the OCaml data science library.\n\n";
  start_ui ()

let () = main ()