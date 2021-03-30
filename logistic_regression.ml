open Matrix

(* Will use gradient descent with this. Check link:
   https://rickwierenga.com/blog/ml-fundamentals/logistic-regression.html*)
let e = 2.7182818284590452353602874713527

let sigmoid z = 1. /. (1. +. (e ** (-1. *. z)))

let num_iter = ref 100

let alpha = ref 0.1

let update_params num a =
  num_iter := num;
  alpha := a

(* applies the product of theta and x to the sigmoid function. x is a
   matrix and theta is a column vector *)
let h x theta =
  let z = matrix (mult x theta) in
  let z_mat = List.map (fun x -> sigmoid (List.hd x)) z in
  construct [ z_mat ]

let compute_gradient theta x y =
  let m = x |> matrix |> List.length in
  let predictions = h x theta |> transpose in
  let gradient =
    scale (mult (transpose x) (op predictions y ( -. ))) (1. /. float_of_int m)
  in
  gradient

let theta = ref (zero 1 1)

let fit x y =
  theta := zero (List.length (List.hd (matrix x))) 1;

  let rec fit_iter i =
    if i < !num_iter then (
      let gradient = compute_gradient !theta x y in
      theta := op !theta (scale gradient !alpha) ( -. );
      fit_iter (i + 1))
  in
  fit_iter 0;
  theta

let predict x = h x !theta
