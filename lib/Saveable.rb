module Saveable
  @associations = {}

  def to_hash_with_id
    hash = {id: get_id}
    self.instance_variables.each() do |var|
      hash[var.to_s.delete("@")] = self.instance_variable_get(var)
    end
    hash
  end

  def class_regex
    /#<#{self.class}:0x\w*>/
  end

  def get_id
    self.to_s.scan(class_regex).first
  end
end