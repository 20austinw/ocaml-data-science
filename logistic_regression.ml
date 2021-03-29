open Matrix

(* Will use gradient descent with this. Check link:
   https://rickwierenga.com/blog/ml-fundamentals/logistic-regression.html*)

(* this is for testing *)
let print_cv cv =
  let cv_list = List.map (fun x -> List.hd x) (matrix cv) in
  print_string (String.concat " " (List.map string_of_float cv_list));
  print_string "\n";
  0

let e = 2.7182818284590452353602874713527

let theta = ref (zero 1 1)

let sigmoid z = 1. /. (1. +. (e ** (-1. *. z)))

(* applies the product of theta and x to the sigmoid function. x is a
   matrix and theta is a column vector *)
let h x theta =
  let z = matrix (mult x theta) in
  let z_mat = List.map (fun x -> sigmoid (List.hd x)) z in
  construct [ z_mat ]

let compute_gradient theta x y =
  let m = x |> matrix |> List.length in
  let predictions = h x theta in
  let t_y = transpose y |> matrix |> List.hd in
  let diff =
    [
      List.mapi
        (fun i e -> e -. List.nth t_y i)
        (predictions |> matrix |> List.hd);
    ]
    |> construct |> transpose
  in
  let gradient = mult (transpose x) diff in
  let g_s = scale gradient (1. /. float_of_int m) in
  print_cv g_s;
  g_s

let num_iter = 10

let alpha = 0.1

let fit x y =
  theta := zero (List.length (List.hd (matrix x))) 1;
  let rec fit_iter i =
    if i < num_iter then (
      let gradient = compute_gradient !theta x y in
      let alpha_grad =
        scale gradient alpha |> transpose |> matrix |> List.hd
      in
      let t_theta = !theta |> transpose |> matrix |> List.hd in

      theta :=
        [ List.mapi (fun i e -> e -. List.nth alpha_grad i) t_theta ]
        |> construct |> transpose;

      fit_iter (i + 1))
  in
  fit_iter 0;
  theta

(* x is a matrix of features. outputes a matrix y of predictions *)
let predict x = h x !theta

(* below this is testing *)
(* testing using a dataset on this link:
   https://towardsdatascience.com/binary-classification-and-logistic-regression-for-beginners-dd6213bf7162 *)

let theta_s = construct [ [ 10.655 ]; [ 0.821 ] ]

let sarah = construct [ [ 4.3 ]; [ 79. ] ]

let s_x =
  construct
    [
      [ 4.; 82. ];
      [ 3.; 80. ];
      [ 2.5; 75. ];
      [ 3.4; 90. ];
      [ 4.2; 88. ];
      [ 5.; 92. ];
      [ 2.7; 99. ];
      [ 3.3; 85. ];
      [ 4.2; 72. ];
      [ 3.6; 80. ];
      [ 2.9; 85. ];
      [ 3.9; 85. ];
      [ 4.5; 99. ];
      [ 4.7; 90. ];
      [ 4.6; 80. ];
      [ 4.6; 75. ];
      [ 3.4; 64. ];
    ]

let s_y =
  construct
    [
      [ 1. ];
      [ 0. ];
      [ 0. ];
      [ 1. ];
      [ 1. ];
      [ 1. ];
      [ 0. ];
      [ 0. ];
      [ 0. ];
      [ 0. ];
      [ 0. ];
      [ 1. ];
      [ 1. ];
      [ 1. ];
      [ 1. ];
      [ 0. ];
      [ 0. ];
    ]

(* returns the new theta based on gradient descent *)
(* let get_new_theta theta x y = let num_features = List.length (List.hd
   (matrix x)) in let m = List.length (matrix x) in let gradients = ref
   (List.init num_features (fun x -> 0.)) in let mat_x = matrix x in let
   mat_y = matrix y in let theta_list = List.map (fun x -> List.hd x)
   (matrix theta) in

   let rec calc_gradients i = if i < m then ( let actual = List.hd
   (List.nth mat_y i) in print_float actual; print_string "\n"; let
   element = List.nth mat_x i in let predicted = h theta (transpose
   (construct [ element ])) in print_float predicted; print_string
   "\n\n"; gradients := List.mapi (fun index e -> (predicted -. actual)
   *. List.nth element index) !gradients; calc_gradients (i + 1)) in

   calc_gradients 0;

   let new_theta_init = List.init num_features (fun x -> 0.) in
   List.mapi (fun i e -> List.nth theta_list i -. (0.002 *. (1. /.
   float_of_int m) *. List.nth !gradients i)) new_theta_init *)

(* x are the features, y is the column vector of either 0 or 1 *)
