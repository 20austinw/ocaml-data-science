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

let nominal_of_one_hot x = ()
let turn_vector_to_diagonal_matrix x = ()

(* Utils specific to SVMs: *)
let linear_kernel = ()
let polynomial_kernel power coef = ()
let rbf_kernel gamma = ()