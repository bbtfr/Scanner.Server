class Ability < Sequel::Model
  plugin :serialization, :json, :use_counts

  ABILITIES = {
    'scanIDCard' => 3,
    'livenessTest' => 3
  }

  def use_count feature
    use_counts[feature] || 0
  end

  def increase_use_count! feature
    use_counts[feature] = use_count(feature) + 1
    save
  end

  def has_ability? feature, limit = ABILITIES[feature]
    use_count(feature) < limit
  end

  def abilities
    abilities = {}
    ABILITIES.each do |feature, limit|
      abilities[feature] = has_ability? feature, limit
    end
    abilities
  end

end
