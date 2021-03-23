open OUnit2
open Matrix
open Statistics

let eye_test name n res = name >:: fun ctxt -> assert_equal res (eye n |> matrix)

let empty_test name m n res =
  name >:: fun ctxt -> assert_equal res (empty m n |> matrix)

let lu_decomp_test name m res =
  name >:: fun ctxt ->
  assert_equal res
    (let x = m |> construct |> lu_decomp in
     (matrix (fst x), matrix (snd x)))

let invert_test name m res =
  name >:: fun ctxt -> assert_equal res (m |> construct |> invert |> matrix)

let det_test name m res =
  name >:: fun ctxt -> assert_equal res (m |> construct |> det)

let matrix_tests =
  [
    eye_test "5x5 identity matrix" 5
      [
        [ 1.0; 0.0; 0.0; 0.0; 0.0 ];
        [ 0.0; 1.0; 0.0; 0.0; 0.0 ];
        [ 0.0; 0.0; 1.0; 0.0; 0.0 ];
        [ 0.0; 0.0; 0.0; 1.0; 0.0 ];
        [ 0.0; 0.0; 0.0; 0.0; 1.0 ];
      ];
    empty_test "5x6 empty matrix" 5 6
      [
        [ 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 ];
        [ 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 ];
        [ 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 ];
        [ 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 ];
        [ 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 ];
      ];
    lu_decomp_test "LU decomposition test 1"
      [ [ 2.0; -1.0; -2.0 ]; [ -4.0; 6.0; 3.0 ]; [ -4.0; -2.0; 8.0 ] ]
      ( [ [ 1.0; 0.0; 0.0 ]; [ -2.0; 1.0; 0.0 ]; [ -2.0; -1.0; 1.0 ] ],
        [ [ 2.0; -1.0; -2.0 ]; [ 0.0; 4.0; -1.0 ]; [ 0.0; 0.0; 3.0 ] ] );
    invert_test "Matrix inverse test 1"
      [ [ 3.0; 0.0; 2.0 ]; [ 2.0; 0.0; -2.0 ]; [ 0.0; 1.0; 1.0 ] ]
      [ [ 0.2; 0.2; 0. ]; [ -0.2; 0.3; 1. ]; [ 0.2; -0.3; 0. ] ];
    det_test "2x2 matrix" [ [ 4.0; 6.0 ]; [ 3.0; 8.0 ] ] 14.0;
    det_test "3x3 matrix"
      [ [ 6.0; 1.0; 1.0 ]; [ 4.0; -2.0; 5.0 ]; [ 2.0; 8.0; 7.0 ] ]
      (-306.0);
    det_test "4x4 matrix"
      [
        [ 1.0; 3.0; 5.0; 9.0 ];
        [ 1.0; 3.0; 1.0; 7.0 ];
        [ 4.0; 3.0; 9.0; 7.0 ];
        [ 5.0; 2.0; 0.0; 9.0 ];
      ]
      (-376.1);
  ]

let suite = "test suite for project" >::: List.flatten [ matrix_tests ]

let _ = run_test_tt_main suite
