class QualityCheck < ApplicationRecord
  belongs_to :production_line
  belongs_to :equipment
end
