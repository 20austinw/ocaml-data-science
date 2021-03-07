module Matrix = struct
  type t = { dimensions : int * int; matrix : float list list }

  exception InvalidDimensions

  let matrix t = t.matrix

  let empty m n =
    {
      dimensions = (m, n);
      matrix = List.init m (fun i -> List.init n (fun j -> 0.0));
    }

  let eye n =
    {
      dimensions = (n, n);
      matrix =
        List.init n (fun i -> List.init n (fun j -> if i = j then 1.0 else 0.0));
    }

  let transpose m =
    let rec helper = function
      | [] -> []
      | [] :: _ -> []
      | (a :: b) :: c ->
          (a :: List.map List.hd c) :: helper (b :: List.map List.tl c)
    in
    { m with matrix = helper m.matrix }

  let mult m1 m2 =
    if snd m1.dimensions != fst m2.dimensions then raise InvalidDimensions
    else
      let product v1 v2 =
        List.fold_left ( +. ) 0.0 (List.map2 (fun x1 x2 -> x1 *. x2) v1 v2)
      in
      let columns = (transpose m2).matrix in
      List.map (fun row -> List.map (product row) columns) m1.matrix
end
