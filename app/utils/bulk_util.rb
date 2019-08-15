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

  def self.bulk_add(file, model, mainIndex, finalIndex)
    success_array = []
    fail_array = []
    fail_instances = []
    csv = CSV.open(file)
    csv.shift
    csv.shift

    hash_keys = model.attribute_names[1, mainIndex]
    csv.each do |row|

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
        success_array.push(instance)
      else
        fail_array.push(csv.lineno)
        fail_instances.push(instance)
      end
    end

    [success_array, fail_array, fail_instances ]
  end
end