open OUnit2
open Matrix
open Statistics

let eye_test name n res = name >:: fun ctxt -> assert_equal res (eye n |> matrix)

let zero_test name m n res =
  name >:: fun ctxt -> assert_equal res (zero m n |> matrix)

let transpose_test name m res =
  name >:: fun ctxt ->
  let mat = m |> construct |> transpose in
  assert_equal res (mat |> matrix);
  assert_equal (List.length res, res |> List.hd |> List.length) (dim mat)

let lu_decomp_test name m res =
  name >:: fun ctxt ->
  assert_equal res
    (let x = m |> construct |> lu_decomp in
     (matrix (fst x), matrix (snd x)))

let invert_test name m res =
  name >:: fun ctxt -> assert_equal res (m |> construct |> invert |> matrix)

let det_test name m res =
  name >:: fun ctxt -> assert_equal res (m |> construct |> det)

let normalize_test name m res =
  name >:: fun ctxt -> assert_equal res (m |> construct |> normalize |> matrix)

let concat_test name m1 m2 res =
  name >:: fun ctxt ->
  assert_equal res (concat (construct m1) (construct m2) |> matrix)

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
    zero_test "5x6 zero matrix" 5 6
      [
        [ 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 ];
        [ 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 ];
        [ 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 ];
        [ 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 ];
        [ 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 ];
      ];
    transpose_test "Transpose test on vector" [ [ 1.; 2.; 3.; 4. ] ]
      [ [ 1. ]; [ 2. ]; [ 3. ]; [ 4. ] ];
    transpose_test "Transpose test on rectangular matrix"
      [ [ 1.; 2.; 3.; 4. ]; [ 2.; 3.; 4.; 5. ]; [ 3.; 4.; 5.; 6. ] ]
      [ [ 1.; 2.; 3. ]; [ 2.; 3.; 4. ]; [ 3.; 4.; 5. ]; [ 4.; 5.; 6. ] ];
    lu_decomp_test "LU decomposition test 1"
      [ [ 2.0; -1.0; -2.0 ]; [ -4.0; 6.0; 3.0 ]; [ -4.0; -2.0; 8.0 ] ]
      ( [ [ 1.0; 0.0; 0.0 ]; [ -2.0; 1.0; 0.0 ]; [ -2.0; -1.0; 1.0 ] ],
        [ [ 2.0; -1.0; -2.0 ]; [ 0.0; 4.0; -1.0 ]; [ 0.0; 0.0; 3.0 ] ] );
    (* invert_test "Matrix inverse test 1"
       [ [ 3.0; 0.0; 2.0 ]; [ 2.0; 0.0; -2.0 ]; [ 0.0; 1.0; 1.0 ] ]
       [ [ 0.2; 0.2; 0. ]; [ -0.2; 0.3; 1. ]; [ 0.2; -0.3; 0. ] ]; *)
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
      (-376.0);
    (let m = [ [ 1.; 2.; 3. ] ] |> construct |> magnitude in
     normalize_test "Normalize test: Row vector" [ [ 1.; 2.; 3. ] ]
       [ [ 1. /. m; 2. /. m; 3. /. m ] ]);
    (let m = [ [ 1. ]; [ 2. ]; [ 3. ] ] |> construct |> magnitude in
     normalize_test "Normalize test: Column vector" [ [ 1. ]; [ 2. ]; [ 3. ] ]
       [ [ 1. /. m ]; [ 2. /. m ]; [ 3. /. m ] ]);
    concat_test "Concat test 1" [ [ 1. ]; [ 2. ]; [ 3. ] ]
      [ [ 1. ]; [ 2. ]; [ 3. ] ]
      [ [ 1.; 1. ]; [ 2.; 2. ]; [ 3.; 3. ] ];
    concat_test "Concat test 2" [ [ 1. ]; [ 2. ]; [ 3. ] ]
      [ [ 1.; 1. ]; [ 2.; 2. ]; [ 3.; 3. ] ]
      [ [ 1.; 1.; 1. ]; [ 2.; 2.; 2. ]; [ 3.; 3.; 3. ] ];
  ]

let suite = "test suite for project" >::: List.flatten [ matrix_tests ]

let _ = run_test_tt_main suite
