class Person < ApplicationRecord
  belongs_to :image
  has_many :identify_callings, foreign_key: :id_number, primary_key: :id_number

  def identify_callings_count
    identify_callings.count
  end

  def accepted_identify_callings_count
    identify_callings.where(validity: 'accepted').count
  end
end
