class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: { scope: :release_year,
    message: "should happen once per year" }
  validate :needs_release_year

  def needs_release_year
    if self.released && self.release_year == nil
      errors.add(:release_year, 'Needs a release year')
    elsif self.release_year != nil && self.release_year > DateTime.now.year
      errors.add(:release_year, 'Release year cannot be in the future.')
    end
  end
end




# - `released`, a `boolean` describing whether the song was ever officially
#   released.
#   - Must be `true` or `false`

# - `release_year`, an `integer`
#   - Optional if `released` is `false`
#   - Must not be blank if `released` is `true`
#   - Must be less than or equal to the current year

# - `artist_name`, a `string`
#   - Must not be blank

# - `genre`, a `string`
