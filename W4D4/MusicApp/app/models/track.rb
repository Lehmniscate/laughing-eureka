# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  name       :string           not null
#  bonus      :boolean          default("false"), not null
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ApplicationRecord
  validates_presence_of :album, :name
  validates :bonus, inclusion: {in: [true, false]}

  belongs_to :album
  has_one :band, through: :album, source: :band
end
