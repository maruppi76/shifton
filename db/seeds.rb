require 'csv'

def seed(csv)
  classname = File.basename(csv, ".*").slice(0..-6).classify
  records = []
  CSV.foreach(csv, headers: true) do |row|
    records << Object.const_get(classname).new(row.to_hash)
  end
   
  Object.const_get(classname).import records, on_duplicate_key_update: records[0].attributes.keys, validate: false
end

Dir.glob("db/data/*.csv").each do |csv| 
 seed(csv)
end