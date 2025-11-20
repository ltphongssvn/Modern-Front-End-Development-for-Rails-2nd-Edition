# manufacturing_erp/app/models/equipment.rb
class Equipment < ApplicationRecord
  belongs_to :production_line
  has_many :maintenance_schedules, dependent: :destroy
  has_many :quality_checks, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :sensor_data, dependent: :destroy
  
  validates :name, :serial_number, presence: true
  validates :status, inclusion: { in: %w[operational maintenance offline] }
end
