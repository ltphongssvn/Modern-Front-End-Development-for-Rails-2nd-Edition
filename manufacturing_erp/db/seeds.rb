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

# Create Equipment for Line B (in maintenance)
equipment3 = line2.equipment.create!(
  name: "CNC Machine B1",
  serial_number: "CNC-2024-003",
  status: "maintenance",
  last_maintenance: 60.days.ago,
  next_maintenance: Date.today,
  operating_hours: 4800
)

# Create Maintenance Schedules
MaintenanceSchedule.create!(
  equipment: equipment1,
  scheduled_date: 30.days.from_now,
  maintenance_type: "Preventive",
  description: "Regular quarterly maintenance",
  status: "scheduled"
)

MaintenanceSchedule.create!(
  equipment: equipment3,
  scheduled_date: Date.today,
  maintenance_type: "Corrective",
  description: "Bearing replacement and calibration",
  status: "in_progress"
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

# Create Recent Alerts
Alert.create!(
  production_line: line2,
  equipment: equipment3,
  alert_type: "Maintenance Required",
  severity: "high",
  message: "Line B CNC Machine requires scheduled maintenance",
  status: "active",
  triggered_at: 2.hours.ago
)

Alert.create!(
  production_line: line1,
  equipment: equipment2,
  alert_type: "Performance Warning",
  severity: "medium",
  message: "Robotic Arm efficiency dropped below 90%",
  status: "active",
  triggered_at: 30.minutes.ago
)

puts "Seeded: #{ProductionLine.count} production lines"
puts "Seeded: #{Equipment.count} equipment"
puts "Seeded: #{MaintenanceSchedule.count} maintenance schedules"
puts "Seeded: #{QualityCheck.count} quality checks"
puts "Seeded: #{Alert.count} alerts"
# Create test user
User.create!(
  email: 'admin@manufacturing.com',
  password: 'password123',
  password_confirmation: 'password123'
)
puts "Created admin user: admin@manufacturing.com / password123"
