# manufacturing_erp/app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  ROLES = %w[admin manager operator viewer].freeze
  
  after_initialize :set_default_role, if: :new_record?
  
  validates :role, inclusion: { in: ROLES }
  
  def admin?
    role == 'admin'
  end
  
  def manager?
    role == 'manager'
  end
  
  def operator?
    role == 'operator'
  end
  
  def viewer?
    role == 'viewer'
  end
  
  def can_edit?
    admin? || manager?
  end
  
  def can_delete?
    admin?
  end
  
  private
  
  def set_default_role
    self.role ||= 'viewer'
  end
end
