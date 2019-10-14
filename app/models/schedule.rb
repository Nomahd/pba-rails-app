class Schedule < ApplicationRecord

  validates :category,
            presence: true,
            length: { maximum: 255 }

  validates :station,
            presence: true,
            length: { maximum: 255 }

  validates :start_day,
            presence: true,
            length: { maximum: 255 }

  validates :time,
            presence: true,
            length: { maximum: 255 }

  def self.bulk(csv)
    CSVUtil.schedule_add(csv)
  end

  def self.destroy_selected(audio, video)
    selected = nil
    unless audio.nil?
      selected = audio
    end
    unless video.nil?
      selected = video
    end
    Program.destroy(selected)
  end
end
