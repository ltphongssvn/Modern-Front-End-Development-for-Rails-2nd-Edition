class Alert < ApplicationRecord
  belongs_to :production_line
  belongs_to :equipment
end
