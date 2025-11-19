# manufacturing_erp/app/models/production_line.rb
class ProductionLine < ApplicationRecord
  has_many :equipment, dependent: :destroy
  has_many :quality_checks, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :sensor_data, dependent: :destroy
  
  validates :name, presence: true
  validates :capacity, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w[active inactive maintenance] }
end
