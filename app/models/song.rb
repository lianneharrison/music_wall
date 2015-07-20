class Song < ActiveRecord::Base

  validates :song_title, presence: true
  validates :author, presence: true
  validates :url, format: { with: /(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?/ }, :allow_blank => true 


end