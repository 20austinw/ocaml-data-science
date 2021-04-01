type point = { tag : int; pos : float * float }

let construct lst =
  let rec helper acc = function
    | [] -> acc
    | x :: xs -> helper ({ tag = 0; pos = x } :: acc) xs
  in
  helper [] lst

let classify points n max_iter =
  let centroids =
    Array.init n (fun i ->
        { tag = i; pos = (Random.float 20.0, Random.float 20.0) })
  in
  let dist p1 p2 =
    let x1 = fst p1.pos
    and y1 = snd p1.pos
    and x2 = fst p2.pos
    and y2 = snd p2.pos in
    Float.sqrt (((x2 -. x1) ** 2.) +. ((y2 -. y1) ** 2.))
  in
  let find_nearest = 
