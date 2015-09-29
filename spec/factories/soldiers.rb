# == Schema Information
#
# Table name: soldiers
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  description             :string(255)
#  str_min                 :integer
#  dex_min                 :integer
#  vit_min                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  str_max                 :integer
#  dex_max                 :integer
#  vit_max                 :integer
#  level_max               :integer
#  critical_hit_chance_min :integer          default(0), not null
#  critical_hit_chance_max :integer          default(0), not null
#  critical_hit_damage_min :integer          default(0), not null
#  critical_hit_damage_max :integer          default(0), not null
#  dodge_chance_min        :integer          default(0), not null
#  dodge_chance_max        :integer          default(0), not null
#  damage_reduction_min    :integer          default(0), not null
#  damage_reduction_max    :integer          default(0), not null
#  ene_min                 :integer          default(0), not null
#  ene_max                 :integer          default(0), not null
#

FactoryGirl.define do
  factory :soldier do
  end
end

