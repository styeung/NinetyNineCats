class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: %w(PENDING APPROVED DENIED)

  belongs_to(
    :cat,
    class_name: "Cat",
    :foreign_key => :cat_id,
    :primary_key => :id,
    dependent: :destroy
  )

  after_initialize do |request|
    request.status ||= "PENDING"
  end

  def overlapping_requests
    between_date_sql = <<-SQL
      NOT ((start_date > :self_end_date)
      OR (:self_start_date > end_date))
      AND cat_id = :self_cat_id
      AND id != :self_id
    SQL

    CatRentalRequest.where(between_date_sql,
                        self_start_date: self.start_date,
                        self_end_date: self.end_date,
                        self_cat_id: self.cat_id,
                        self_id: self.id)
  end

  def overlapping_approved_requests
    self.overlapping_requests.where(status: "APPROVED")
  end

  def pending?
    self.status == "PENDING"
  end

  def approve!
    CatRentalRequest.transaction do
      if overlapping_approved_requests.empty?
        self.overlapping_requests.each do |request|
          request.deny!
        end

        self.status = "APPROVED"
        self.save!
      else
        self.deny!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end
end
