class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :date
      t.string :booking_time
      t.integer :number_of_holes
      t.string :course
      t.string :phone
      t.string :email
      t.string :note
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
