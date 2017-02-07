class ModelBase

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM #{self::TABLE}
      WHERE id = ?
    SQL
    return nil if data.empty?
    new(data.first)
  end

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self::TABLE}
    SQL
    data.map {|datum| new(datum)}
  end

  def save
    var_names = instance_variables.reject { |i| instance_variable_get(i).nil? }
    var_values = var_names.map { |i| instance_variable_get(i) }
    var_names = var_names.map { |i| i.to_s[1..-1]}
    if @id.nil?
      question_marks = ['?'] * var_values.length
      QuestionsDatabase.instance.execute(<<-SQL, var_values)
        INSERT INTO
          #{self::TABLE} (#{var_names.join(", ")})
        VALUES
          ( #{question_marks.join(", ")} )
      SQL
      @id =  QuestionsDatabase.instance.last_insert_row_id
    else
      var_names = var_names.map {|v| "#{v} = ?"}[1..-1]
      var_values = var_values[1..-1] + [var_values[0]]
      QuestionsDatabase.instance.execute(<<-SQL, var_values)
        UPDATE
          #{self::TABLE}
        SET
          #{var_names.join(", ")}
        WHERE
          id = ?
      SQL
    end
  end

  def self.where(options)
    var_names = options
    arguments = nil
    
    unless options.is_a?(String)
      var_names = options.keys.map {|key| key.to_s + " LIKE ?"}.join(" AND ")
      arguments = options.values.map {|value| "%#{value}%"}
    end

    data = QuestionsDatabase.instance.execute(<<-SQL, arguments)
      SELECT
        *
      FROM
        #{self::TABLE}
      WHERE
        #{var_names}
      SQL
    data.map {|datum| new(datum)}
  end

  def self.method_missing(method_name, *args)
    raise "method missing" unless method_name.to_s.start_with?("find_by_")

    keys = method_name.to_s[8 .. -1].split("_and_")

    keys.map! {|key| key.to_sym}

    options = Hash.new()
    keys.each_with_index do |key, i|
      options[key] = args[i]
    end

    self.where(options)
  end

end
