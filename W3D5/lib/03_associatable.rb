require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || name.to_s.camelcase
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] || "#{self_class_name.to_s.singularize.downcase}_id".to_sym
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || name.to_s.singularize.camelcase
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, opt = {})
    assoc_options[name] = BelongsToOptions.new(name, opt)
    define_method(name) do
      options = self.class.assoc_options[name]

      owner_key = options.primary_key
      f_k = self.send(options.foreign_key)

      options.model_class.where(owner_key => f_k).first
    end
  end

  def has_many(name, opt = {})
    assoc_options[name] = HasManyOptions.new(name, self, opt)
    define_method(name) do
      options = self.class.assoc_options[name]

      f_k = options.foreign_key
      owner_key = self.send(options.primary_key)
      
      options.model_class.where(f_k => owner_key)
    end
  end

  def assoc_options
    @assoc_options ||= {}
    @assoc_options
  end
end

class SQLObject
  extend Associatable
end
