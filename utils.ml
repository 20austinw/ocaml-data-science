let entropy_for_label y label = 
  let log2 x = (Float.log x) /. (Float.log 2.) in
  let count = List.length (List.filter (fun x -> x = label) y) in 
  let p = float_of_int (count / (List.length y)) in 
  -1. *. p *. log2 p

let calculate_entropy y = 
  let unique_labels = List.sort_uniq compare y in
  List.map (fun label -> entropy_for_label y label) unique_labels 
  |> Statistics.sum

let diff l1 l2 = 
  try 
    List.mapi (fun i x -> List.nth l1 i -. List.nth l2 i) l1 
  with _ -> failwith "List lengths do not match"

let mean_squared_error y_true y_pred = 
  Statistics.mean(List.map (fun x -> x ** 2.) (diff y_true y_pred))

let distance x1 x2 = 
  List.map (fun x -> x ** 2.) (diff x1 x2)
  |> Statistics.sum
  |> Float.sqrt

let accuracy y_true y_pred = 
  try
    let num_of_same_values = 
      List.mapi (fun i x -> 
        if List.nth y_true i = List.nth y_pred i then 1 else 0) y_true
      |> List.filter (fun x -> x = 1)
      |> List.length in 
    num_of_same_values / List.length y_true
  with _ -> failwith "List lengths do not match"
  
let normalize x = ()

let split x y test_percent = 
  if test_percent >= 1. then failwith "Make sure the test_percent < 1"
  else
    let split_i = int_of_float 
      (float_of_int (List.length y) -. 
      (float_of_int (List.length y) /. (1. /. test_percent))) in
    let x_train = List.filteri (fun i x -> i <= split_i) x in
    let x_test = List.filteri (fun i x -> i > split_i) x in
    let y_train = List.filteri (fun i x -> i <= split_i) y in
    let y_test = List.filteri (fun i x -> i > split_i) y in
    (x_train, x_test, y_train, y_test)
    
let split_with_cross_val x y test_percent cross_percent = 
  if cross_percent +. test_percent >= 1. then 
    failwith "Make sure test_percent and cross_percent amount to less than 1"
  else
    let split_cr = int_of_float 
      (float_of_int (List.length y) -. 
      (float_of_int (List.length y) /. 
      (1. /. (cross_percent +. test_percent)))) in
    let split_test = int_of_float 
      (float_of_int (List.length y) -. 
      (float_of_int (List.length y) /. 
      (1. /. test_percent))) in
    let x_validation = List.filteri (fun i x -> 
      i > split_cr && i <= split_test) x in
    let y_validation = List.filteri (fun i x -> 
      i > split_cr && i <= split_test) y in
    let x_train = List.filteri (fun i x -> i <= split_cr) x in
    let x_test = List.filteri (fun i x -> i > split_test) x in
    let y_train = List.filteri (fun i x -> i <= split_cr) y in
    let y_test = List.filteri (fun i x -> i > split_test) y in
    (x_train, x_validation, x_test, y_train, y_validation, y_test)

let (--) lo hi =
  let rec loop lo hi acc =
    if lo > hi then acc
    else loop (lo + 1) hi (lo :: acc) in
  List.rev (loop lo hi [])

let one_hot_of_nominal x = 
  let n_col = List.hd (List.sort -compare x) in
  let one_hot = Matrix.empty (List.length x) n_col in

  ()


let nominal_of_one_hot x = ()
let turn_vector_to_diagonal_matrix x = ()

(* Utils specific to SVMs: *)
let linear_kernel = ()
let polynomial_kernel power coef = ()
let rbf_kernel gamma = ()