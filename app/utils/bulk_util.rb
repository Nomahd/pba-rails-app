require 'csv'

class BulkUtil

  def self.row_count(file)
    csv = CSV.open(file)
    csv.shift
    csv.shift

    row_count = 0
    csv.each do
      row_count += 1
    end

    row_count
  end

  def self.extract_audio_filenames(file)
    csv = CSV.open(file)
    csv.shift
    csv.shift

    filenames = []
    csv.each do |row|
      filenames.push(row[8])
    end
    filenames
  end

  def self.bulk_add(rows, modelString, mainIndex, finalIndex)
    model = modelString.constantize
    total = rows.length - 2
    ActionCable.server.broadcast("csv_progress", total: total)

    hash_keys = model.attribute_names[1, mainIndex]
    rows.each_with_index do |value, index|
      unless index < 2
        line = CSV.parse(value)
        row = line[0]
        row.map! { |col| col.nil? ? '' : col }
        instance = model.new(Hash[hash_keys.zip(row[0, mainIndex])])
        if model.name == 'Audio'
          instance.audio_file = 'ignore'
        end
        x = mainIndex
        while x <= finalIndex
          if row[x] != nil
            split_string = row[x].split(Regexp.union(%w(, /))).map(&:strip)
            if x == mainIndex
              instance.genre_list.add(split_string)
            end
            if x == mainIndex + 1
              instance.theme_list.add(split_string)
            end
            if x == mainIndex + 2
              instance.special_list.add(split_string)
            end
          end
          x += 1
        end
        if instance.valid?
          instance.save
          ActionCable.server.broadcast("csv_progress", 'success')
        else
          ActionCable.server.broadcast("csv_progress", fail: {line: index, errors: instance.errors.full_messages})
        end
      end
    end
  end
end