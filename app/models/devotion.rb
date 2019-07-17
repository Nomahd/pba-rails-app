class Devotion < ApplicationRecord
  validates :pba_id,
            length: {maximum: 255}
  validates :title,
            presence: true,
            length: {maximum: 255}
  validates :release_date,
            presence: true
  validates :body,
            presence: true
  validates :messenger,
            length: {maximum: 255}
  validates :bible_book,
            length: {maximum: 255}

  acts_as_taggable_on :genres, :themes, :specials

  attr_reader :success_count, :fail_array

  after_save do
    self.genre_list.each do |tag|
      TagMeta.create(:name => tag, :context => 'devotion', :category => 'genre')
    end

    self.theme_list.each do |tag|
      TagMeta.create(:name => tag, :context => 'devotion', :category => 'theme')

    end

    self.special_list.each do |tag|
      TagMeta.create(:name => tag, :context => 'devotion', :category => 'special')
    end
  end

  def self.get_page(page)
    if page == nil
      Devotion.page(1)
    else
      Devotion.page(page)
    end
  end

  def self.bulk(file)
    @success_count = 0
    @fail_array = []
    csv = CSV.open(file)
    csv.shift
    csv.shift

    hash_keys = Devotion.attribute_names[1, 7]
    csv.each do |row|
      d = Devotion.new(Hash[hash_keys.zip(row[0, 7])])
      x = 7
        while x <=9
          if row[x] != nil
            split_string = row[x].split(Regexp.union(%w(, /))).map(&:strip)
            if x == 7
              d.genre_list.add(split_string)
            end
            if x == 8
              d.theme_list.add(split_string)
            end
            if x == 9
              d.special_list.add(split_string)
            end
          end
          x += 1
        end
      if d.save
        @success_count += 1
      else
        @fail_array.push(csv.lineno)
      end
    end

    [@success_count, @fail_array]
  end
end
