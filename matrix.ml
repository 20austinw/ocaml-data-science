module Matrix = struct
  type t = { dimensions : int * int; matrix : float list list }

  let matrix t = t.matrix

  let empty m n =
    {
      dimensions = (m, n);
      matrix = List.init m (fun x -> List.init n (fun x -> 0.0));
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
    else failwith "Unimplemented"
end
