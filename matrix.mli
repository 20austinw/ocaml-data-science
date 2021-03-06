module type Matrix = sig
  type t

  exception InvalidDimensions

  (* [matrix t] retrieves the matrix within t *)
  val matrix : t -> float list list

  (* [empty m n] produces an m by n matrix of 0's *)
  val empty : int -> int -> t

  (* [eye n] produces an n by n identity matrix *)
  val eye : int -> t

  (* [transpose t] transposes the matrix in t *)
  val transpose : t -> t

  (* [mult t1 t2] produces a new matrix of the product of t1 and t2 *)
  val mult : t -> t -> t
end
