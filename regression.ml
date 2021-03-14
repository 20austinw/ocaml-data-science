(** Main template for doing regression that will define 
    optimization for both linear and polynomial regression. 
    [fit] and [predict] are going to be different for 
    linear and polynomial regression, so is [t] so it might
    be a good idea to have those two be sub modules.*)

type t = {
  num_iterations : int;
  learning_rate : float;
}

let initialize_weights num_features = ()
let fit x y = () (* Gradient descent happens here. *)
let predict x = ()