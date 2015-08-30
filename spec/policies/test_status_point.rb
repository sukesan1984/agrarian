RSpec.describe StatusPoint  do
  it "decrease" do
    status_point = StatusPoint.new(10, 50)
    expect(status_point.current).to eq 10
    status_point.decrease("hoge")
    expect(status_point.current).to eq 10
    status_point.decrease(3)
    expect(status_point.current).to eq 7
    status_point.decrease(8)
    expect(status_point.current).to eq 0
    status_point.decrease(-1)
    expect(status_point.current).to eq 1
    status_point.decrease(-70)
    expect(status_point.current).to eq 50
  end

  it "increase" do
    status_point = StatusPoint.new(10, 50)
    status_point.increase(4)
    expect(status_point.current).to eq 14
    status_point.increase("hoge")
    expect(status_point.current).to eq 14
    status_point.increase(40)
    expect(status_point.current).to eq 50
    status_point.increase(-1)
    expect(status_point.current).to eq 49
    status_point.increase(-50)
    expect(status_point.current).to eq 0
  end

  it "operator" do
    status_point = StatusPoint.new(10, 50)
    status_point -= 3
    expect(status_point.current).to eq 7
    status_point -= 10
    expect(status_point.current).to eq 0
    status_point += 3
    expect(status_point.current).to eq 3
    status_point += 50
    expect(status_point.current).to eq 50
  end
end
