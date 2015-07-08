class StatusPointTest < ActiveSupport::TestCase
  test "decrease" do
    status_point = StatusPoint.new(10, 50)
    assert_equal(status_point.current, 10)
    status_point.decrease("hoge")
    assert_equal(status_point.current, 10)
    status_point.decrease(3)
    assert_equal(status_point.current, 7)
    status_point.decrease(8)
    assert_equal(status_point.current, 0)
    status_point.decrease(-1)
    assert_equal(status_point.current, 1)
    status_point.decrease(-70)
    assert_equal(status_point.current, 50)
  end

  test "increase" do
    status_point = StatusPoint.new(10, 50)
    status_point.increase(4)
    assert_equal(status_point.current, 14)
    status_point.increase("hoge")
    assert_equal(status_point.current, 14)
    status_point.increase(40)
    assert_equal(status_point.current, 50)
    status_point.increase(-1)
    assert_equal(status_point.current, 49)
    status_point.increase(-50)
    assert_equal(status_point.current, 0)
  end

  test "operator" do
    status_point = StatusPoint.new(10, 50)
    status_point -= 3
    assert_equal(status_point.current, 7)
    status_point -= 10
    assert_equal(status_point.current, 0)
    status_point += 3
    assert_equal(status_point.current, 3)
    status_point += 50
    assert_equal(status_point.current, 50)
  end
end
