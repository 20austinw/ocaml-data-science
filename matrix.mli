(** Representation of matrices

    This module represents matrices and houses key matrix functions*)

(** type [t] represents a matrix with dimensions [dimensions] and values
    represented by the float list list [matrix]*)
type t = {
  dimensions : int * int;
  matrix : float list list;
}

(** Raised when a matrix function cannot be applied due to different
    dimensions*)
exception InvalidDimensions of string

(** [dim m] returns the dimensions of matrix m *)
val dim : t -> int * int

(** [matrix m] returns the the float list list representation of matrix
    m*)
val matrix : t -> float list list

(** [fill m n x] returns a m x n matrix filled with float x *)
val fill : int -> int -> float -> t

(** [empty m n] produces an m x n matrix of 0's *)
val zero : int -> int -> t

(** [eye n] produces an n x n identity matrix *)
val eye : int -> t

(** [transpose m] transposes the matrix m*)
val transpose : t -> t

(** [mult m1 m2] produces a new matrix of the product of m1 and m2 *)
val mult : t -> t -> t

(** [echelon m] returns the reduced form of matrix m*)
val rref : t -> t

(** [construct m] takes in a float list list m and returns matrix.
    Throws InvalidDimensions if rows are not of the same length *)
val construct : float list list -> t

(** [decomp m] produces a pair of matrices containing the
    LU-decomposition of matrix m*)
val lu_decomp : t -> t * t

(** [concat m1 m2] concatenates m1 and m2 and returns the resulting
    matrix [m1 m2]*)
val concat : t -> t -> t

(** [invert m] returns the inverse of matrix m. Throws InvalidDimensions
    if m is not a square matrix. *)
val invert : t -> t

(** [pinv m] returns the pseudoinverse of matrix m*)
val pinv : t -> t

(** [det m] returns the determinant of matrix m *)
val det : t -> float

(** [magnitude m] takes in a matrix of type t and returns its magnitude
    Requires: m is a vector *)
val magnitude : t -> float

(** [normalize m] returns a normalized vector if m is a vector. m / (det
    m) is returned otherwise. *)
val normalize : t -> t

(** [eigen mat dom] returns a pair float * t containing the eigenvector
    and its associated eigenvalue. If dom is true then function returns
    the dominant eigenvector, else the smallest. *)
val eigen : t -> bool -> float * t

(** [elem_pow m r] raises each entry of m to the power of r and returns
    the resulting matrix.*)
val elem_pow : t -> float -> t

(** [scale m c] takes in m and scales it by factor of c*)
val scale : t -> float -> t

(** [op m1 m2 f] applies the operator f to pair of elements in m1 m2 and
    returns a matrix containing \[\[f a1 b1; f a2 b2; ...\]; ...\] *)
val op : t -> t -> (float -> float -> float) -> t

(** [dot v1 v2] returns the dot product between two vectors. If v1 and
    v2 are two dimensional matrices instead, performs [mult v1 v2]*)
val dot : t -> t -> float

(** [elem_f m f] applies the element-wise function f to matrix m and
    returns the resulting matrix *)
val elem_f : t -> (float -> float) -> t
