RSpec.describe RecipeMakingService do
  it 'calculation successable rate' do
    expect(RecipeMakingService.calculate_successable_rate(900, 90)).to eq 100
    expect(RecipeMakingService.calculate_successable_rate(800, 90)).to eq 50
    expect(RecipeMakingService.calculate_successable_rate(700, 90)).to eq 25
    expect(RecipeMakingService.calculate_successable_rate(600, 90)).to eq 12.5
    expect(RecipeMakingService.calculate_successable_rate(500, 90)).to eq 6.25 
    expect(RecipeMakingService.calculate_successable_rate(400, 90)).to eq 3.125
  end
end

