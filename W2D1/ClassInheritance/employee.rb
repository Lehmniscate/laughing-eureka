class Employee

  attr_reader :salary

  def initialize(name, title, salary, boss = nil)
    @name, @title, @salary, @boss = name, title, salary, boss
    @boss.add_employee(self) if @boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end


end
