let k = ref 5

let set_k new_k = k := new_k

(* Return the most common class among the neighbor samples *)
let vote labels =
  let uniq_labels = List.sort_uniq compare labels in
  let counts =
    List.map
      (fun x -> (x, List.length (List.filter (fun a -> a = x) labels)))
      uniq_labels
  in
  let sorted_counts =
    List.sort (fun a b -> compare (snd a) (snd b)) counts |> List.rev
  in
  List.nth sorted_counts 0 |> fst

(* computes the euclidean distance of x and y *)
let euclidean_distance x y =
  Float.sqrt
    (List.fold_left2
       (fun init a b -> ((b -. a) *. (b -. a)) +. init)
       0. x y)

(* argsort implementation *)
let arg_sort lst num =
  let arg_tuple = List.mapi (fun i elt -> (i, elt)) lst in
  let sorted_tuple =
    List.sort (fun a b -> compare (snd a) (snd b)) arg_tuple
  in
  let arg_lst = fst (List.split sorted_tuple) in
  List.filteri (fun i elt -> i < num) arg_lst

(* x_train and x_test is list of float list, y_train *)
let predict x_test x_train y_train =
  let y_pred = ref [] in
  List.iteri
    (fun i tst_elt ->
      let distances =
        List.map (fun x -> euclidean_distance x tst_elt) x_train
      in
      let idx = arg_sort distances !k in
      let knn = List.map (fun x -> List.nth y_train x) idx in
      y_pred := vote knn :: !y_pred)
    x_test;

  List.rev !y_pred
