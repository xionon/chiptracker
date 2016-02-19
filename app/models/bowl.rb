class Bowl < ActiveRecord::Base
  belongs_to :person

  scope :most_chips_since, ->(date) {
    find_by_sql([most_chips_since_query, date: date])
  }

  scope :sum_for_person, ->(person_id) {
    select("SUM(bowls.chips) AS chips")
      .where(person_id: person_id)
  }

  def self.most_chips_since_query
    <<-SQL.strip_heredoc
      SELECT SUM(bowls.chips), people.id, people.household_id
      FROM bowls
      WHERE bowls.created_at > :date
      JOIN people ON people.id = bowls.person_id
      GROUP BY 2, 3
      ORDER BY 1 DESC
      LIMIT 5;
    SQL
  end
end
