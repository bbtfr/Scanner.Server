class Ability < ApplicationRecord
  FEATURES = %w(scan_id_card liveness_test)
  CHECK_ABILITY = false

  serialize :use_counts, Hash

  def abilities
    FEATURES.reduce({}) do |ret, feature|
      ret[feature] = has_ability?(feature)
      ret
    end
  end

  def use_count feature
    use_counts[feature] || 0
  end

  def has_ability? feature
    return true unless CHECK_ABILITY
    use_count(feature) > 0
  end

  def decrease_use_count! feature
    return true unless CHECK_ABILITY
    use_counts[feature] = use_count(feature) - 1
    save!
  end
end
