class CreateSurveys < ActiveRecord::Migration[4.2]
  def change
    create_table :surveys do |t|
      t.string :name
      t.boolean :live
      t.boolean :scoreable
      t.boolean :image_result
      t.string :image

      t.timestamps
    end
  end
end
