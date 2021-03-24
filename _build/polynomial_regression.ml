open Matrix

(* Source: https://towardsdatascience.com/implementing-linear-and-polynomial-regression-from-scratch-f1e3d422e6b4 *)
let fit x y n =
  let rec create r x acc =
    if r = n + 1 then acc
    else create (r + 1) x (concat acc (elem_pow x (float_of_int r)))
  in
  concat (elem_pow x (float_of_int 1)) (elem_pow x (float_of_int 1)) |> matrix
(* let x = create 1 x (fill (x |> dim |> fst) 1 1.0) in
   x |> matrix *)

let predict x = failwith "Unimplemented"
