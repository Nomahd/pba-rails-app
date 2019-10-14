class Program < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { scope: :context },
            length: { maximum: 255 }

  validates :context,
            presence: true,
            length: { maximum: 255 }

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
