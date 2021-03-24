open Matrix

(* Source: https://towardsdatascience.com/implementing-linear-and-polynomial-regression-from-scratch-f1e3d422e6b4 *)
let fit x y n =
  let rec create r acc =
    if r = n + 1 then acc
    else create (r + 1) (concat acc (elem_pow x (float_of_int r)))
  in
  let x = create 1 (fill (x |> dim |> fst) 1 1.0) in


let predict x = failwith "Unimplemented"
