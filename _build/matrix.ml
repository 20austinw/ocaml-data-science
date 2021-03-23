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
    {
      dimensions = (fst m1.dimensions, snd m2.dimensions);
      matrix = List.map (fun row -> List.map (product row) columns) m1.matrix;
    }

let to_array m = Array.of_list (List.map Array.of_list m)

let to_list m = Array.to_list (Array.map Array.to_list m)

let swap m i j =
  let temp = m.(i) in
  m.(i) <- m.(j);
  m.(j) <- temp

let rref mat =
  let m = to_array mat.matrix in
  let lead = ref 0 in
  let rowCount = Array.length m in
  let columnCount = Array.length m.(0) in
  try
    for r = 0 to pred rowCount do
      if columnCount <= !lead then raise Exit;
      let i = ref r in
      while m.(!i).(!lead) = 0.0 do
        incr i;
        if rowCount = !i then (
          i := r;
          incr lead;
          if columnCount = !lead then raise Exit)
      done;
      swap m !i r;
      let le = m.(r).(!lead) in
      if le != 0.0 then m.(r) <- Array.map (fun x -> x /. le) m.(r);
      for i = 0 to pred rowCount do
        if i != r then
          let le = m.(i).(!lead) in
          m.(i) <- Array.mapi (fun i x -> x -. (le *. m.(r).(i))) m.(i)
      done;
      incr lead
    done;
    { mat with matrix = to_list m }
  with Exit -> { mat with matrix = to_list m }

let construct lst =
  let rec check = function
    | [] -> lst
    | [ h ] -> lst
    | a :: b :: c ->
        if List.length a != List.length b then raise InvalidDimensions
        else check (b :: c)
  in
  {
    dimensions = (List.length lst, List.length (List.hd lst));
    matrix = check lst;
  }

let lu_decomp mat =
  let n = fst mat.dimensions in
  let m = mat.matrix |> to_array in
  let l = (empty n n).matrix |> to_array in
  let u = (empty n n).matrix |> to_array in
  for i = 0 to pred n do
    for k = i to pred n do
      let sum = ref 0.0 in
      for j = 0 to pred i do
        sum := !sum +. (l.(i).(j) *. u.(j).(k))
      done;
      Printf.sprintf "%0.5f" !sum;
      u.(i).(k) <- m.(i).(k) -. !sum
    done;
    for k = i to pred n do
      if i = k then l.(i).(i) <- 1.0
      else
        let sum = ref 0.0 in
        for j = 0 to pred i do
          sum := !sum +. (l.(k).(j) *. u.(j).(i));
          l.(k).(i) <- (m.(k).(i) -. !sum) /. u.(i).(i)
        done
    done
  done;
  ( { dimensions = (n, n); matrix = l |> to_list },
    { dimensions = (n, n); matrix = u |> to_list } )
