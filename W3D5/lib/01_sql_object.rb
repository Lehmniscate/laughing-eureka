require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    query = <<-SQL
      SELECT #{table_name}.*
      FROM #{table_name}
    SQL

    @columns ||= DBConnection.execute2(query).first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column|
      define_method("#{column}") do
        @attributes ||= {}
        @attributes[column]
      end

      define_method("#{column}=") do |value|
        @attributes ||= {}
        @attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= to_s.tableize
    @table_name
  end

  def self.all
    parse_all DBConnection.execute(<<-SQL)
      SELECT #{table_name}.*
      FROM #{table_name}
    SQL
  end

  def self.parse_all(results)
    results.map { |r| new(r) }
  end

  def self.find(id)
    r =  DBConnection.execute(<<-SQL, id)
      SELECT #{table_name}.*
      FROM #{table_name}
      WHERE id = ?
    SQL

    return nil if r.empty?
    new(r.first)
  end

  def initialize(params = {})
    params.each do |atr, value|
      raise "unknown attribute '#{atr}'" unless self.class.columns.include?(atr.to_sym)
      send("#{atr}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map {|i| attributes[i]}
  end

  def insert
    col_names = self.class.columns - [:id]
    vals = attribute_values.drop(1)
    DBConnection.execute(<<-SQL, vals)
      INSERT INTO #{self.class.table_name} (#{col_names.join(", ")})
      VALUES (#{(['?'] * col_names.length).join(', ')})
    SQL
    attributes[:id] = DBConnection.last_insert_row_id
  end

  def update
    col_names = self.class.columns.drop(1).map{|i| "#{i} = ?"}
    vals = attribute_values.drop(1) + attribute_values.take(1)
    DBConnection.execute(<<-SQL, vals)
      UPDATE #{self.class.table_name}
      SET #{col_names.join(", ")}
      WHERE id = ?
    SQL
  end

  def save
    attributes[:id].nil? ? insert : update
  end
end
