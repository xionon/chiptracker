class Person < ActiveRecord::Base
  belongs_to :household
  has_many :bowls

  def self.top_chip_eaters_from_each_household
    # This query will an array of hashes:
    # [{"total_chips" => number, "person_id" => id, "household_id" => id}]
    sql = <<-SQL.strip_heredoc
      WITH chip_sums AS (
        SELECT SUM(chips) AS total_chips, person_id, people.household_id
        FROM bowls
        JOIN people ON people.id = bowls.person_id
        WHERE bowls.created_at > NOW() - INTERVAL '2 days'
        GROUP BY 2, 3
        ORDER BY 1 DESC
      )
      (SELECT * FROM chip_sums WHERE household_id = 1 LIMIT 3)
      UNION ALL
      (SELECT * FROM chip_sums WHERE household_id = 2 LIMIT 3)
      UNION ALL
      (SELECT * FROM chip_sums WHERE household_id = 3 LIMIT 3)
      UNION ALL
      (SELECT * FROM chip_sums WHERE household_id = 4 LIMIT 3)
      ;
    SQL

    # For these purposes, we only care about the "person_id" key
    ids = Person.connection.execute(sql).to_a.map { |result| result["person_id"] }

    # Now we can use those IDs to get the full person records. You could probably do some
    # clever JOINing in the main query to avoid this second query, as well
    return Person.where(id: ids)
  end
end
