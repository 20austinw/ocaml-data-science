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

let swap m i j = 
  let temp = m.(i) in 
  m.(i) <- m.(j); 
  m.(j) <- temp;

  let swap m i j =
    let temp = m.(i) in
    m.(i) <- m.(j);
    m.(j) <- temp

  (* Seems like rref requires the use of arrays. It would make sense for us to implement
     matrices using arrays, but lists make the code cleaner and more concise. *)
     let echelon mat =
       let m = Array.of_list (List.map Array.of_list mat.matrix) in
       let lead = ref 0 in
       let rowCount = Array.length m in
       let columnCount = Array.length m.(0) in
       try
         for r = 0 to (pred rowCount) do
           if columnCount <= lead then raise Exit
           let i = ref r in
           while m.(!i).(!lead) = 0 do
             incr i;
             if rowCount = !i then (
               i := r;
               incr lead;
               if columnCount = !lead then raise Exit
              )
           done;
        done;
                  with Exit -> ();;

  let construct lst =
    { dimensions = (List.length lst, List.length (List.hd lst)); matrix = lst }
end
