open Matrix

(* Will use gradient descent with this. Check link:
   https://rickwierenga.com/blog/ml-fundamentals/logistic-regression.html *)
let e = 2.7182818284590452353602874713527

let w = ref (fill 1 1 (Random.float 1.0))

let g z = 1. /. (1. +. (e ** (-1.0 *. z)))

let h x = elem_f (mult x !w) g

let compute_gradient x y =
  let preds = h x in
  scale
    (mult (transpose x) (op preds y ( -. )))
    (1. /. float_of_int (x |> dim |> fst))

let rec fit x y alpha n =
  for j = 0 to pred n do
    let gradient = compute_gradient x y in
    w := op !w (scale gradient alpha) ( -. )
  done;
  !w

let predict x = h x
