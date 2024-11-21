print "\n\"Maybe\" monad test suite"

setup do
  [Maybe.wrap("Hello, World!"), Maybe.wrap(nil)]
end

test "Maybe::new" do
  assert_raise NoMethodError do Maybe.new(42) end

  assert_raise TypeError do Just.new(nil) end
  assert Just.new(42).is_a?(Just)

  assert_raise ArgumentError do Nothing.new(42) end
  assert Nothing.new.is_a?(Nothing)
end

test "Maybe::wrap" do |just, nothing|
  assert just.is_a?(Maybe)
  assert just.is_a?(Just)
  assert !just.is_a?(Nothing)

  assert nothing.is_a?(Maybe)
  assert !nothing.is_a?(Just)
  assert nothing.is_a?(Nothing)

  assert Maybe.wrap(just).is_a?(Just)
  assert Maybe.wrap(nothing).is_a?(Nothing)
end

test "Maybe#bind" do |just, nothing|
  assert just.bind { |v| Maybe.wrap(v.to_sym) }.is_a?(Just)
  assert just.bind { |v| Maybe.wrap(nil) }.is_a?(Nothing)
  assert_raise TypeError do just.bind { |v| v.to_sym } end

  assert nothing.bind { |v| Maybe.wrap(42) }.is_a?(Nothing)
  assert nothing.bind { |v| Maybe.wrap(nil) }.is_a?(Nothing)
  assert nothing.bind { |v| v.to_sym }.is_a?(Nothing)
end

test "Maybe#fmap" do |just, nothing|
  assert just.fmap(&:to_sym).is_a?(Just)
  assert just.fmap { |v| nil }.is_a?(Nothing)

  assert nothing.fmap(&:to_sym).is_a?(Nothing)
  assert nothing.fmap { |v| 42 }.is_a?(Nothing)
end

test "Maybe#join" do |just, nothing|
  assert_equal Maybe.wrap(just).join.unwrap("default"), "Hello, World!"
  assert_equal Maybe.wrap(nothing).join.unwrap("default"), "default"
end

test "Maybe#unwrap" do |just, nothing|
  assert_equal just.unwrap("default"), "Hello, World!"
  assert_equal just.unwrap(nil), "Hello, World!"
  assert_equal nothing.unwrap("default"), "default"
  assert_equal nothing.unwrap(nil), nil
end

test "Maybe accepts methods chaining" do |just, nothing|
  assert_equal just.upcase.reverse.split.unwrap([]), ["!DLROW", ",OLLEH"]
  assert_equal nothing.upcase.reverse.split.unwrap([]), []
end
