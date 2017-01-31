require_relative "employee.rb"
require "byebug"

class Manager < Employee
  def initialize(name, title, salary, boss = nil)
    super
    @employees = []
  end

  def bonus(multiplier)
    employee_salary = @employees.inject(0) do |bonus, employee|
      bonus + (employee.bonus(multiplier))
    end
    manager_salary = @employees.inject(0) do |sal, employee|
      if employee.is_a?(Manager)
        sal + employee.salary * multiplier
      else
        sal
      end
    end
    employee_salary + manager_salary
  end

  def total_employee_salary

  end

  def add_employee(employee)
    @employees << employee unless @employees.include?(employee)
  end
end
