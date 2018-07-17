class AddPositionToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :position, :integer
    User.all.each do |user|
      user.projects.order(:id).each.with_index(1) do |project, index|
        project.update_column :position, index
      end
    end
  end
end
