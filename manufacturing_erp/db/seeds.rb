# manufacturing_erp/db/seeds.rb
# Clear existing data
[SensorDatum, Alert, QualityCheck, MaintenanceSchedule, Equipment, ProductionLine].each(&:destroy_all)

# Create Production Lines
line1 = ProductionLine.create!(
  name: "Assembly Line A",
  status: "active",
  capacity: 1000,
  current_output: 850,
  efficiency: 85.0,
  location: "Building 1, Floor 2"
)

line2 = ProductionLine.create!(
  name: "Assembly Line B",
  status: "maintenance",
  capacity: 800,
  current_output: 0,
  efficiency: 0.0,
  location: "Building 1, Floor 3"
)

# Create Equipment for Line A
equipment1 = line1.equipment.create!(
  name: "CNC Machine A1",
  serial_number: "CNC-2024-001",
  status: "operational",
  last_maintenance: 30.days.ago,
  next_maintenance: 30.days.from_now,
  operating_hours: 2400
)

equipment2 = line1.equipment.create!(
  name: "Robotic Arm A2",
  serial_number: "ROB-2024-002",
  status: "operational",
  last_maintenance: 15.days.ago,
  next_maintenance: 45.days.from_now,
  operating_hours: 1200
)

# Create Maintenance Schedules
MaintenanceSchedule.create!(
  equipment: equipment1,
  scheduled_date: 30.days.from_now,
  maintenance_type: "Preventive",
  description: "Regular quarterly maintenance",
  status: "scheduled"
)

# Create Quality Checks
QualityCheck.create!(
  production_line: line1,
  equipment: equipment1,
  check_type: "Dimensional",
  result: "Pass",
  severity: "low",
  performed_at: 1.hour.ago,
  notes: "All tolerances within spec"
)

# Create Recent Alert
Alert.create!(
  production_line: line2,
  alert_type: "Maintenance Required",
  severity: "high",
  message: "Line B requires scheduled maintenance",
  status: "active",
  triggered_at: 2.hours.ago
)

puts "Seeded: #{ProductionLine.count} production lines"
puts "Seeded: #{Equipment.count} equipment"
puts "Seeded: #{MaintenanceSchedule.count} maintenance schedules"
puts "Seeded: #{QualityCheck.count} quality checks"
puts "Seeded: #{Alert.count} alerts"
