class DrawerCollaborator < ApplicationRecord
  belongs_to :friend, class_name: "User"
  belongs_to :drawer
end
