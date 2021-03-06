RSpec.describe DamageCalculation do
  it 'get_chance_to_hit' do
    attacker_status = Status.new(0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    defender_status = Status.new(0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    damage_calculation = DamageCalculation.new(attacker_status, defender_status)
    expect(damage_calculation.get_chance_to_hit).to eq 200 * 5.fdiv(5 + 10)

    # 95を超えるとき
    attacker_status = Status.new(0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    defender_status = Status.new(0, 0, 10, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    damage_calculation = DamageCalculation.new(attacker_status, defender_status)
    expect(damage_calculation.get_chance_to_hit).to eq 95

    # minimum以下
    attacker_status = Status.new(0, 0, 10, 10,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    defender_status = Status.new(0, 0, 10, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    damage_calculation = DamageCalculation.new(attacker_status, defender_status)
    expect(damage_calculation.get_chance_to_hit).to eq 5

    # dodge_chance設定されていたら。
    #
    attacker_status = Status.new(0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    defender_status = Status.new(0, 0, 10, 0,  0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0)
    damage_calculation = DamageCalculation.new(attacker_status, defender_status)
    expect(damage_calculation.get_chance_to_hit).to eq 85
  end
end
