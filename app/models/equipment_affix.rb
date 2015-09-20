# == Schema Information
#
# Table name: equipment_affixes
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  equipment_type         :integer
#  affix_group            :integer
#  affix_type             :integer
#  rarity                 :integer
#  damage_perc_min        :integer
#  damage_perc_max        :integer
#  attack_rating_perc_min :integer
#  attack_rating_perc_max :integer
#  defense_perc_min       :integer
#  defense_perc_max       :integer
#  hp_min                 :integer
#  hp_max                 :integer
#  hp_steal_perc_min      :integer
#  hp_steal_perc_max      :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class EquipmentAffix < ActiveRecord::Base
  module AffixType
    Prefix = 1
    Suffix = 2
  end

  def prefix?
    return self.affix_type == AffixType::Prefix
  end

  def suffix?
    return self.affix_type == AffixType::Suffix
  end

  def self.get_one_random_prefix(item_rarity)
    return self.where('affix_type = ? and rarity <= ?', AffixType::Prefix, item_rarity).sample
  end

  def self.get_one_random_suffix(item_rarity)
    return self.where('affix_type = ? and rarity <= ?', AffixType::Suffix, item_rarity).sample
  end

  # それぞれのパラメータのmin/maxの定義があるもののmin-maxの値にある値を返す
  def get_random_value
    hash = {}
    # damage_perc
    if self.damage_perc_min != 0 && self.damage_perc_max != 0 
      hash[:damage_perc] = EquipmentAffix::get_random_value_by_min_and_max(self.damage_perc_min, self.damage_perc_max)
    end

    # attack_rating_perc
    if self.attack_rating_perc_min != 0 && self.attack_rating_perc_max != 0 
      hash[:attack_rating_perc] = EquipmentAffix::get_random_value_by_min_and_max(self.attack_rating_perc_min, self.attack_rating_perc_max)
    end

    # defense_perc
    if self.defense_perc_min != 0 && self.defense_perc_max != 0 
      hash[:defense_perc] = EquipmentAffix::get_random_value_by_min_and_max(self.defense_perc_min, self.defense_perc_max)
    end

    # hp
    if self.hp_min != 0 && self.hp_max != 0 
      hash[:hp] = EquipmentAffix::get_random_value_by_min_and_max(self.hp_min, self.hp_max)
    end

    # hp_steal_perc
    if self.hp_steal_perc_min != 0 && self.hp_steal_perc_max != 0 
      hash[:hp_steal_perc] = EquipmentAffix::get_random_value_by_min_and_max(self.hp_steal_perc_min, self.hp_steal_perc_max)
    end

    return hash
  end

  def self.get_random_value_by_min_and_max(min, max)
    center = (min + max).to_f / 2.0
    return GaussianRandomize::rand_int(center, (center - min).to_f / 2.0, min, max)
  end
end
