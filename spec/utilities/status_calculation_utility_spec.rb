RSpec.describe StatusCalculationUtility do
  it 'calculation' do
    expect(StatusCalculationUtility.calculate(1, 10, 10, 3)).to eq 3
  end
end

