open Matrix

let w = ref (zero 1 1)

(* Source: https://medium.com/analytics-vidhya/linear-regression-and-polynomial-regression-using-normal-equation-method-c3929d71734d *)
let fit x y n =
  let rec create r acc =
    if r = n + 1 then acc
    else create (r + 1) (concat acc (elem_pow x (float_of_int r)))
  in
  let x = create 1 (fill (x |> dim |> fst) 1 1.0) in
  let x' = transpose x in
  let dot_inverse = x |> mult x' |> invert in
  let w_ = y |> mult (x' |> mult dot_inverse) in
  w := w_;
  w_

let predict x =
  let n = !w |> dim |> fst in
  let rec make r acc =
    if r = n then acc
    else make (r + 1) (concat acc (elem_pow x (float_of_int r)))
  in
  let x' = make 0 (List.init (x |> dim |> fst) (fun x -> []) |> construct) in
  mult x' !w
