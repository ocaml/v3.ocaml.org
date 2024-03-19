open OUnit2

module type Testable = sig
  val preorder : 'a binary_tree -> 'a list
  val inorder : 'a binary_tree -> 'a list
  val pre_in_tree : 'a list -> 'a list -> 'a binary_tree
end

module Make(Tested: Testable) : sig val v : test end = struct
  let v = "preorder, inorder, pre_in_tree" >::: [
    "test_preorder_works_correctly" >:: (fun _ ->
      let open BinaryTree in
      let example_tree =
        Node ('a', Node ('b', Node ('d', Empty, Empty), Node ('e', Empty, Empty)),
             Node ('c', Empty, Node ('f', Node ('g', Empty, Empty), Empty))) in
      let expected_preorder = ['a'; 'b'; 'd'; 'e'; 'c'; 'f'; 'g'] in
      assert_equal expected_preorder (Tested.preorder example_tree));

    "test_inorder_works_correctly" >:: (fun _ ->
      let open BinaryTree in
      let example_tree =
        Node ('a', Node ('b', Node ('d', Empty, Empty), Node ('e', Empty, Empty)),
             Node ('c', Empty, Node ('f', Node ('g', Empty, Empty), Empty))) in
      let expected_inorder = ['d'; 'b'; 'e'; 'a'; 'c'; 'g'; 'f'] in
      assert_equal expected_inorder (Tested.inorder example_tree));

    "test_pre_in_tree_works_correctly" >:: (fun _ ->
      let open BinaryTree in
      let pre_seq = ['a'; 'b'; 'd'; 'e'; 'c'; 'f'; 'g'] in
      let in_seq = ['d'; 'b'; 'e'; 'a'; 'c'; 'g'; 'f'] in
      let expected_tree =
        Node ('a', Node ('b', Node ('d', Empty, Empty), Node ('e', Empty, Empty)),
             Node ('c', Empty, Node ('f', Node ('g', Empty, Empty), Empty))) in
      assert_equal expected_tree (Tested.pre_in_tree pre_seq in_seq))
  ]
end

module Work : Testable = Work.Impl

module Answer : Testable = Answer.Impl
