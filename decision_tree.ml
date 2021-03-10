type node = {
  feature_i : int;
  threshold : float;
  value : float;
  true_branch : node;
  false_branch : node;
}

type t = {
  root: node;
  min_samles_split : int;
  min_impurity : float;
  max_depth : int;
}

let impurity_calculate = ()
let leaf_value_calculate = ()
let fit x y = ()
let build_tree x y = ()
let predict x = ()