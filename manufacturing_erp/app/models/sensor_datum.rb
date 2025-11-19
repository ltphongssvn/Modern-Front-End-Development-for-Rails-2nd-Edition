class SensorDatum < ApplicationRecord
  belongs_to :equipment
  belongs_to :production_line
end
